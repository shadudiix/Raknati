//
//  GeoLocationFirebaseModel.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 02/12/2022.
//

import Foundation
import CoreLocation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class GeoLocationFirebaseModel: Codable {
    
    @DocumentID var id: String?
    @ServerTimestamp var createdAt: Timestamp?
    var inProcessing: Bool!
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    init(id: String? = nil, createdAt: Timestamp? = nil, inProcessing: Bool, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.id = id
        self.createdAt = createdAt
        self.inProcessing = inProcessing
        self.latitude = latitude
        self.longitude = longitude
    }
}

