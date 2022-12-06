//
//  AppCoordinator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import Foundation
import UIKit

final class AppCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var navigationController: UINavigationController!
    var childCoordinators: [Coordinator]! = .init()
    private let sessionManager = SessionManager.shared

    init(navigationController: UINavigationController) {
        super.init()
        self.navigationController = navigationController
        self.navigationController.delegate = self
    }
        
    func configureRootViewController() {
        if(self.sessionManager.isSignedIn()) {
            self.showHomeViewController()
        } else {
            self.showSignInViewController()
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if let signInViewController = fromViewController as? SignInViewController {
            childDidFinish(signInViewController.presenter.coordinator)
        }

        if let homeViewController = fromViewController as? HomeViewController {
            childDidFinish(homeViewController.presenter.coordinator)
        }

    }
    
    func didSignOut(_ child: Coordinator!) {
        self.childDidFinish(child)
        self.showSignInViewController()
    }
    
    func didSignIn(_ child: Coordinator!) {
        self.childDidFinish(child)
        self.showHomeViewController()
    }
}

extension AppCoordinator {
  
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    func showHomeViewController() {
        let homeCoordinator = HomeCoordinator(navigationController: self.navigationController)
        homeCoordinator.parentCoordinator = self
        self.childCoordinators.append(homeCoordinator)
        homeCoordinator.configureRootViewController()

    }
    
    func showSignInViewController() {
        let authenticationCoordinator = AuthenticationCoordinator(navigationController: self.navigationController)
        authenticationCoordinator.parentCoordinator = self
        self.childCoordinators.append(authenticationCoordinator)
        authenticationCoordinator.configureRootViewController()
    }
    
}


