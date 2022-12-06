//
//  EmailAuthenticationService.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import Foundation
import FirebaseAuth

protocol EmailAuthenticationService: AnyObject {
    func signInWithEmailAddress(
        _ emailAddress: String!,
        _ securePassword: String!,
        handler: @escaping(Result<User, Error>) -> ())
}
