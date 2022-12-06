//
//  GeoLocationEntity.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 02/12/2022.
//

import Foundation
import CoreLocation

final class GeoLocationEntity: Encodable {
    let latitude: CLLocationDegrees!
    let longitude: CLLocationDegrees!
    
    init(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        self.latitude = latitude
        self.longitude = longitude
    }
}
