//
//  ResetPasswordAdapter.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import FirebaseAuth

final class ResetPasswordAdapter: EmailResetService {
    
    func requestResetPassword(
        _ emailAddress: String!,
        handler: @escaping(Result<Bool, Error>) -> ()) {
        Auth.auth().sendPasswordReset(withEmail: emailAddress) { resetPasswordError in
            guard let resetPasswordError = resetPasswordError else {
                handler(.success(true))
                return
            }
            handler(.failure(resetPasswordError))
        }
    }
    
}
