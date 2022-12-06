//
//  HomeRepositoryDelegates.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 02/12/2022.
//

import Foundation

protocol HomeRepository {
    func save(_ data: GeoLocationEntity!, handler: @escaping (Result<String, Error>) -> ())
    func retrieveLastGeoPoint(handler: @escaping(Result<GeoLocationFirebaseModel, Error>) -> ())
    func stopTracking(documentUUID: String!, handler: @escaping(Result<Bool, Error>) -> ())
}
