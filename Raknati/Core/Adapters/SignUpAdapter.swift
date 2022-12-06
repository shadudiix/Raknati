//
//  SignUpAdapter.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 05/12/2022.
//

import FirebaseAuth

final class SignUpAdapter: EmailSignUpService {
    
    func signUpViaEmail(
        _ emailAddress: String!,
        _ securePassword: String!,
        _ displayName: String!,
        _ handler: @escaping(Result<User, Error>) -> ()) {
            Auth.auth().createUser(withEmail: emailAddress, password: securePassword) { authResult, isError in
                if let isError = isError {
                    handler(.failure(isError))
                } else {
                    guard let _ = authResult else {
                        handler(.failure(RaknatiErrorCodes.anErrorOccurred))
                        return
                    }
                    guard let currentUser = Auth.auth().currentUser else {
                        handler(.failure(RaknatiErrorCodes.anErrorOccurred))
                        return
                    }
                    var changeRequest = currentUser.createProfileChangeRequest()
                    changeRequest.displayName = displayName
                    changeRequest.commitChanges { isError in
                        guard let isError = isError else {
                            currentUser.reload { _ in
                                handler(.success(currentUser))
                            }
                            return
                        }
                        handler(.failure(isError))
                    }
                }
            }
        }
}
