//
//  ApodRepository.swift
//  APOD
//
//  Created by Juan Diego Marin 28/10/22.
//

import Foundation
import UIKit
import CoreData

protocol PlanetRepositoryProtocol {
    func getPlanet(completionHandler: @escaping (Result<[PlaneratyInformation], Error>) -> Void)
}

class ApodRepository: PlanetRepositoryProtocol {
    
    func getPlanet(completionHandler: @escaping (Result<[PlaneratyInformation], Error>) -> Void) {
        let localInfo = self.getPlanet()
        if localInfo.count > 0 {
            completionHandler(.success(localInfo))
            return
        }
        let url = URL(string: "https://api.nasa.gov/planetary/apod?api_key=nlPhgpIyS3n4JpMFOMaWpMw6pQKhchCNfsWFz4Wa&start_date=2022-01-10&end_date=2022-01-20")!
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    completionHandler(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
                return
            }
            
            if let data = data,
               let info = try? JSONDecoder().decode([PlaneratyInformation].self, from: data) {
                DispatchQueue.main.async {
                    self.deletePlanet()
                    self.savePlanet(info)
                    completionHandler(.success(info))
                }
            }
        })
        task.resume()
    }
    
    func savePlanet(_ planet: [PlaneratyInformation]) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        planet.forEach { planet in
            let planetCoreData = ApodCD(context: appDelegate.persistentContainer.viewContext)
            planetCoreData.copyright = planet.copyright
            planetCoreData.date = planet.date
            planetCoreData.explanation = planet.explanation
            planetCoreData.hdurl = planet.hdurl
            planetCoreData.mediaType = planet.mediaType
            planetCoreData.serviceVersion = planet.serviceVersion
            planetCoreData.title = planet.title
            planetCoreData.url = planet.url
            appDelegate.saveContext()
        }
    }
    
    private func getPlanet() -> [PlaneratyInformation] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return []
        }
        var planets: [PlaneratyInformation]  = []
        do {
            let fetchRequest: NSFetchRequest<ApodCD> = ApodCD.fetchRequest()
            let coreDataPlanet = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            
            coreDataPlanet.forEach {
                let back = PlaneratyInformation(copyright: $0.copyright,
                                                date: $0.date,
                                                explanation: $0.explanation,
                                                hdurl: $0.hdurl,
                                                mediaType: $0.mediaType,
                                                serviceVersion: $0.serviceVersion,
                                                title: $0.title,
                                                url: $0.url)
                planets.append(back)
            }
        } catch {
            print(error.localizedDescription)
        }
        return planets
    }
    
    private func deletePlanet() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        do {
            let fetchRequest: NSFetchRequest<ApodCD> = ApodCD.fetchRequest()
            let CoreDataCourses = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            CoreDataCourses.forEach {
                appDelegate.persistentContainer.viewContext.delete($0)
            }
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}
