//
//  ResetPasswordVCPresenter.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import Foundation

final class ResetPasswordVCPresenter: NSObject {
    
    // MARK: - Properties

    private weak var view: ResetPasswordDelegates?
    
    private weak var coordinator: AuthenticationCoordinator?
    
    private let sessionManager = SessionManager.shared
    
    // MARK: - Initialization
    
    init(view: ResetPasswordDelegates!, coordinator: AuthenticationCoordinator!) {
        super.init()
        self.view = view
        self.coordinator = coordinator
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions
    
    @objc func sendEmailClicked(_ sender: Any!) {
        guard let emailAddress = self.view?.emailAddress, emailAddress.validateString(.emailAddress) else {
            self.view?.showAlert(RaknatiErrorCodes.emailAddressError.localizedDescription)
            return
        }
        self.view?.showLoading()
        self.sessionManager.requestResetPassword(self.view?.emailAddress) { [weak self] requestResult in
            guard let self = self else { return }
            self.view?.hideLoading()
            switch(requestResult) {
                case .failure(let resetError):
                    self.view?.showAlert(resetError.localizedDescription)
                case .success(_):
                    self.coordinator?.didSentEmailReset()
                    self.view?.showAlert(
                            "Thank you, all accounts pertaining to that email address have now been sent an email with details on how to reset the password."
                    )
            }
        }
    }
    
}
