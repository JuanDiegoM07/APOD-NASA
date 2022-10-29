//
//  ApodRepository.swift
//  APOD
//
//  Created by Wilson David Molina Lozano on 28/10/22.
//

import Foundation
import UIKit
import CoreData


class ApodRepository {
    
    func getPlanet(completionHandler: @escaping (Result<[PlaneratyInformation], Error>) -> Void) {
        
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
}
