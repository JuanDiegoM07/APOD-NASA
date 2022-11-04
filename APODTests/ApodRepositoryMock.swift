//
//  ApodRepositoryMock.swift
//  APODTests
//
//  Created by Juan Diego Marin on 1/11/22.
//

import Foundation
@testable import APOD

class ApodRepositoryMock: PlanetRepositoryProtocol {
    var planet: [PlaneratyInformation]?
    
    func getPlanet(completionHandler: @escaping (Result<[PlaneratyInformation], Error>) -> Void) {
        if let planets = planet {
            completionHandler(.success(planets))
        }
    }
}
