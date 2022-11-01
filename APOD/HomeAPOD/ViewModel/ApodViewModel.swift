//
//  ApodViewModel.swift
//  APOD
//
//  Created by Juan Diego Marin on 31/10/22.
//

import Foundation

class ApodViewModel {
    
    //MARK: - Internal Properties
    
    var error: (String) -> Void = {_ in}
    var success: () -> Void = {}
    var planet: [PlaneratyInformation] = []
    
    //MARK: - Private Properties

    private var repository: PlanetRepositoryProtocol
    
    init(repository: PlanetRepositoryProtocol) {
        self.repository = repository
    }
    
    func getPlanet() {
        repository.getPlanet { result in
            switch result {
                
            case .success(let planet):
                self.planet = planet
                self.success()
            case .failure(let error):
                self.error(error.localizedDescription)
            }
        }
    }

}
