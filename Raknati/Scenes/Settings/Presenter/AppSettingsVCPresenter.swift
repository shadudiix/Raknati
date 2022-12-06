//
//  SettingsVCPresenter.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import Foundation
import UserNotifications


final class AppSettingsVCPresenter: NSObject {
    
    // MARK: - Properties
    
    private var viewDidLoaded: Bool = false
    
    private let sessionManager = SessionManager.shared
    
    private let appSettingsManager = AppSettingsManager.shared
    
    private weak var view: AppSettingsViewDelegates?
    
    private weak var delegates: HomePresenterDelgates?
    
    weak var coordinator: HomeCoordinator?
    
    // MARK: - Initialization
    
    init(view: AppSettingsViewDelegates!, coordinator: HomeCoordinator!, delegates: HomePresenterDelgates!) {
        super.init()
        self.view = view
        self.coordinator = coordinator
        self.delegates = delegates
    }
    
    // MARK: - Object Life Cycle
    
    deinit {
        print("deinit \(self)")
    }
    
    // MARK: - Functions

    func viewIsLoaded() {
        if(self.viewDidLoaded == false) {
            if let currentUserName = self.sessionManager.currentUser?.displayName {
                self.view?.setNameLabel(currentUserName)
            } else {
                self.view?.setNameLabel("Unknown")
            }
            if self.sessionManager.isEmailVerified() {
                self.view?.setEmailVerifiedLabel("Email is verified ✅")
            } else {
                self.view?.setEmailVerifiedLabel("Email is not verified ❌")
            }
            self.view?.setDarkMode(appSettingsManager.darkModeIsON)
            self.viewDidLoaded.toggle()
        }
    }
    
    // MARK: - Buttons Events
    
    @objc func signOutButtonClicked(_ sender: Any!) {
        self.view?.showYesNoQuestion("Are you sure you want to sign out?") { [weak self] alertResult in
            guard let self = self, alertResult == true else { return }
            do {
                self.delegates?.stopLocationUpdates()
                try self.sessionManager.signOut()
                self.coordinator?.didSignOut()
            } catch {
                self.view?.showAlert(error.localizedDescription)
            }
        }
    }
    
    @objc func darkModeSwitchButtonClciked(_ sender: Any!) {
        if(self.viewDidLoaded) {
            guard let sender = sender as? UISwitchStatus else { return }
            appSettingsManager.darkModeIsON = sender.buttonIsOn
            self.view?.showAlert("All changes will take place after restart the application.")
        }
    }

}
