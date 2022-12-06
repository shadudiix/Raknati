//
//  SignInVCPresenter.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import Foundation

final class SignInVCPresenter: NSObject {
    
    // MARK: - Properties
    
    private weak var view: SignInDelegates?
    
    weak var coordinator: AuthenticationCoordinator?
    
    private let sessionManager = SessionManager.shared
    
    // MARK: - Initialization
    
    init(view: SignInDelegates!, coordinator: AuthenticationCoordinator!) {
        super.init()
        self.view = view
        self.coordinator = coordinator
    }

    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }

    
    // MARK: - Buttons Events
    
    @objc func resetPasswordClicked(_ sender: Any!) {
        self.coordinator?.pushResetPasswordView()
    }
   
    @objc func signInButtonClicked(_ sender: RaknatiBaseUIButton!) {
        guard let emailAddress = self.view?.emailAddress, emailAddress.validateString(.emailAddress) else {
            self.view?.showAlert(RaknatiErrorCodes.emailAddressError.localizedDescription)
            return
        }
        guard let securePassword = self.view?.securePassword, securePassword.validateString(.securePassword) else {
            self.view?.showAlert(RaknatiErrorCodes.passwordError.localizedDescription)
            return
        }
       self.view?.showLoading()
       self.sessionManager.signInWithEmailAddress(emailAddress, securePassword) { [weak self] authResult in
           guard let self = self else { return }
           self.view?.hideLoading()
           switch(authResult) {
            case .failure(let authError):
               self.view?.showAlert(authError.localizedDescription)
            case .success(_):
               self.view?.showToast("Welcome Back!")
               self.coordinator?.didSignIn()
           }
       }
   }
    
    @objc func createAccountClicked(_ sender: Any!) {
        coordinator?.pushSignUpViewConntroller()
    }
    

}
