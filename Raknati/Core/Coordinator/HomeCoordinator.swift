//
//  HomeCoordinator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import Foundation
import UIKit

final class HomeCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinator?
    
    var navigationController: UINavigationController!
    var childCoordinators: [Coordinator]! = .init()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func configureRootViewController() {
        let viewController = HomeViewControllerConfigrator.createHomeVC(coordinator: self)
        self.navigationController.setViewControllers([viewController], animated: true)
    }
  
    func pushAppSettings(delegates: HomePresenterDelgates!) {
        let viewController = AppSettingsViewControllerConfigrator.createAppSettingsVC(coordinator: self, delegates: delegates)
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    func didSignOut() {
        parentCoordinator?.didSignOut(self)
    }
    
    deinit {
        print("deinit \(self)")
    }
}
