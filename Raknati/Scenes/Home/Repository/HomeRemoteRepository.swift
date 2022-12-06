//
//  HomeRemoteRepository.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 02/12/2022.
//

import Foundation

final class HomeRemoteRepository: HomeRepository {

    // MARK: - Properties
    
    private let firebaseService: FirebaseService!
    
    // MARK: - Initialization
    
    init(firebaseService: FirebaseService!) {
        self.firebaseService = firebaseService
    }

    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }

    // MARK: - Functions
    
    func save(_ data: GeoLocationEntity!, handler: @escaping (Result<String, Error>) -> ()) {
        let firebaseModel = GeoLocationFirebaseModel.init(inProcessing: true, latitude: data.latitude, longitude: data.longitude)
        firebaseService.createDocument(.ParkingLocationsCollection, firebaseModel) { saveResult in
            switch(saveResult) {
                case .success(let documentUUID):
                    handler(.success(documentUUID))
                case .failure(let createError):
                    handler(.failure(createError))
            }
        }
    }
    
    func retrieveLastGeoPoint(handler: @escaping(Result<GeoLocationFirebaseModel, Error>) -> ()) {
        firebaseService.retrieveLast(
            .ParkingLocationsCollection, retrieveAs: GeoLocationFirebaseModel.self,
            orderBy: "createdAt", whereField: "inProcessing", isEqualTo: true) { fetchResult in
            switch(fetchResult) {
                case .failure(let fetchError):
                    handler(.failure(fetchError))
                case .success(let geoModel):
                if let geoModel = geoModel as? GeoLocationFirebaseModel {
                    handler(.success(geoModel))
                } else {
                    handler(.failure(RaknatiErrorCodes.anErrorOccurred))
                }
            }
        }
    }
    
    func stopTracking(documentUUID: String!, handler: @escaping(Result<Bool, Error>) -> ()) {
        firebaseService.updateDocument(.ParkingLocationsCollection, documentUUID, fields: ["inProcessing" : false], handler: handler)
    }
}
