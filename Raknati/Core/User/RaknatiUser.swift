//
//  RaknatiUser.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import Foundation

struct RaknatiUser {
    
    let uuid: String!
    let displayName: String!
    let isEmailVerified: Bool!
    
    init(uuid: String!, displayName: String!, isEmailVerified: Bool!) {
        self.uuid = uuid
        self.displayName = displayName
        self.isEmailVerified = isEmailVerified
    }
}

