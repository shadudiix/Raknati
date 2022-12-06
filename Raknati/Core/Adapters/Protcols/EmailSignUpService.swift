//
//  EmailSignUpService.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 05/12/2022.
//

import FirebaseAuth

protocol EmailSignUpService: AnyObject {
    func signUpViaEmail(
        _ emailAddress: String!,
        _ securePassword: String!,
        _ displayName: String!,
        _ handler: @escaping(Result<User, Error>) -> ())
}
