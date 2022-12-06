//
//  HomeRepositoryManager.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 02/12/2022.
//

import Foundation

final class HomeRepositoryManager {
    
    // MARK: - Properties
    
    private let remoteRepository: HomeRepository!

    // MARK: - Initialization
    
    init(remoteRepository: HomeRepository!) {
        self.remoteRepository = remoteRepository
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions
    
    func saveEntity(_ geoEntity: GeoLocationEntity!, handler: @escaping (Result<(String), Error>) -> ()) {
        remoteRepository.save(geoEntity) {saveReuslt in
            switch(saveReuslt) {
                case .success(let documentUUID):
                    handler(.success(documentUUID))
                case .failure(let saveError):
                    handler(.failure(saveError))
            }
        }
    }
    
    func retrieveLastGeoPoint(handler: @escaping(Result<(GeoLocationEntity, String), Error>) -> ()) {
        remoteRepository.retrieveLastGeoPoint { retrieveResult in
            switch(retrieveResult) {
                case .success(let geoModel):
                    let geoEntity = GeoLocationEntity.init(latitude: geoModel.latitude, longitude: geoModel.longitude)
                    handler(.success((geoEntity, geoModel.id!)))
                case .failure(let retrieveError):
                    handler(.failure(retrieveError))
            }
        }
    }
    
    func stopTracking(documentUUID: String!, handler: @escaping(Result<Bool, Error>) -> ()) {
        self.remoteRepository.stopTracking(documentUUID: documentUUID, handler: handler)
    }
    
}

