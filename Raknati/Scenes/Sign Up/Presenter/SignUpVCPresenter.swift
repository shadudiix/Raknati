//
//  SignUpVCPresenter.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 05/12/2022.
//

import Foundation

final class SignUpVCPresenter: NSObject {
    
    // MARK: - Properties
    
    private let sessionManager = SessionManager.shared
    
    private weak var view: SignUpVCDelegates?
    
    private weak var coordinator: AuthenticationCoordinator?
    
    // MARK: - Initialization
    
    init(view: SignUpVCDelegates!, coordinator: AuthenticationCoordinator!) {
        super.init()
        self.view = view
        self.coordinator = coordinator
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }

    // MARK: - Buttons Events
    
    @objc func signUpButtonClicked(_ sender: Any!) {
        guard let displayName = self.view?.displayName, displayName.validateString(.displayName) else {
            self.view?.showAlert(RaknatiErrorCodes.displayName.localizedDescription)
            return
        }
        guard let emailAddress = self.view?.emailAddress, emailAddress.validateString(.emailAddress) else {
            self.view?.showAlert(RaknatiErrorCodes.emailAddressError.localizedDescription)
            return
        }
        guard let securePassword = self.view?.securePassword, securePassword.validateString(.securePassword) else {
            self.view?.showAlert(RaknatiErrorCodes.passwordError.localizedDescription)
            return
        }
        self.view?.showLoading()
        self.sessionManager.signUpViaEmail(emailAddress, securePassword, displayName) { [weak self] authResult in
            guard let self = self else { return }
            self.view?.hideLoading()
            switch(authResult) {
                case .failure(let errorCode):
                    self.view?.showAlert(errorCode.localizedDescription)
                case .success(_):
                    self.view?.showToast("Welcome to our family!")
                    self.coordinator?.didSignIn()
            }
        }
    }
}
