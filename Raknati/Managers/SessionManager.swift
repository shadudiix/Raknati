//
//  SessionManager.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import Foundation
import FirebaseAuth


final class SessionManager {
    
    // MARK: - Static Properties
    
    static let shared = SessionManager()
    
    // MARK: - Properties
    
    private let emailAuthenticationServices: EmailAuthenticationService =
        AuthenticationViaEmailAddressAdapter()
    
    private let emailResetPasswordService: EmailResetService =
        ResetPasswordAdapter()
    
    private let emailSignUpService: EmailSignUpService =
        SignUpAdapter()
    
    var currentUser: RaknatiUser?
    
    // MARK: - Object Life Cycle / Singleton
    
    private init() {
        guard let firebaseUser = Auth.auth().currentUser else {
            self.currentUser = nil
            return
        }
        self.mapUserToAppUser(firebaseUser)
    }
    
    func isSignedIn() -> Bool {
        return !(self.currentUser == nil)
    }
    
    func isEmailVerified() -> Bool {
        guard let currentFirebaseUser = Auth.auth().currentUser else {
            return false
        }
        return currentFirebaseUser.isEmailVerified
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
        self.currentUser = nil
    }
    
    func signInWithEmailAddress(
        _ emailAddress: String!,
        _ securePassword: String!,
        handler: @escaping(Result<Bool, Error>) -> ()) {
        self.emailAuthenticationServices.signInWithEmailAddress(emailAddress, securePassword) { [weak self] authResult in
            guard let self = self else { return }
            switch(authResult) {
                case .success(let firebaseUser):
                    self.mapUserToAppUser(firebaseUser)
                    handler(.success(true))
                case .failure(let firebaseError):
                    handler(.failure(firebaseError))
            }
        }
    }
    
    func signUpViaEmail(
        _ emailAddress: String!,
        _ securePassword: String!,
        _ displayName: String!,
        _ handler: @escaping(Result<Bool, Error>) -> ()) {
            self.emailSignUpService.signUpViaEmail(emailAddress, securePassword, displayName) { [weak self] authResult in
                guard let self = self else { return }
                switch(authResult) {
                    case .success(let firebaseUser):
                        self.mapUserToAppUser(firebaseUser)
                         Auth.auth().currentUser?.sendEmailVerification(completion: { _ in
                             handler(.success(true))
                         })
                    case .failure(let FirebaseError):
                        handler(.failure(FirebaseError))
                }
        }
    }
    
    func requestResetPassword(
        _ emailAddress: String!,
        handler: @escaping(Result<Bool, Error>) -> ()) {
            self.emailResetPasswordService.requestResetPassword(emailAddress, handler: handler)
    }
    
    
    private func mapUserToAppUser(_ firebaseUser: User!) {
        guard let displayName = firebaseUser.displayName else {
            do {
                try self.signOut()
            } catch {}
            return
        }
        self.currentUser = RaknatiUser(
            uuid: firebaseUser.uid,
            displayName: displayName,
            isEmailVerified: firebaseUser.isEmailVerified
        )
    }
    
}
