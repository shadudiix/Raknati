//
//  AuthenticationViaEmailAddressAdapter.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import Foundation
import FirebaseAuth

final class AuthenticationViaEmailAddressAdapter: EmailAuthenticationService {
    
    func signInWithEmailAddress(
        _ emailAddress: String!,
        _ securePassword: String!,
        handler: @escaping (Result<User, Error>) -> ()) {
        
        Auth.auth().signIn(withEmail: emailAddress, password: securePassword) { authResult, authError in
            if let authError = authError {
                handler(.failure(authError))
            } else {
                guard let authResult = authResult else {
                    handler(.failure(RaknatiErrorCodes.anErrorOccurred))
                    return
                }
                handler(.success(authResult.user))
            }
        }
    }
    
}
