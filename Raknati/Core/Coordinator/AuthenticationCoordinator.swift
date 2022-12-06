//
//  AuthenticationCoordinator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import Foundation
import UIKit


final class AuthenticationCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    var navigationController: UINavigationController!
    var childCoordinators: [Coordinator]! = .init()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func configureRootViewController() {
        let viewController = SignInViewControllerConfigrator.createSignInVC(coordinator: self)
        self.navigationController.setViewControllers([viewController], animated: true)
    }
    
    func pushResetPasswordView() {
        let viewController = ResetPasswordViewControllerConfigrator.createResetVC(coordinator: self)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushSignUpViewConntroller() {
        let viewController = SignUpViewControllerConfigrator.createSignUpView(coordinator: self)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func didSentEmailReset() {
        self.navigationController.popViewController(animated: true)
    }
    
    func didSignIn() {
        parentCoordinator?.didSignIn(self)
    }
    deinit {
        print("deinit \(self)")
    }

}
