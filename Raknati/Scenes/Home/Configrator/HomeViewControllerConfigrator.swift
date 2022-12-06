//
//  HomeViewControllerConfigrator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 29/11/2022.
//

import UIKit
import CoreLocation

final class HomeViewControllerConfigrator {
    
    class func createHomeVC(coordinator: HomeCoordinator!) -> UIViewController {
        let baseHomeViewController = HomeViewController(viewType: .mainView)
        let baseLoactionManager = CLLocationManager()
        baseLoactionManager.desiredAccuracy = kCLLocationAccuracyBest
        baseLoactionManager.activityType = .otherNavigation
        let baseRempoteRepo = HomeRemoteRepository.init(firebaseService: .init())
        let baseRepoManager = HomeRepositoryManager(remoteRepository: baseRempoteRepo)
        let basePresnter = HomeVCPresenter(
            locationManager: baseLoactionManager,
            homeRepoManager: baseRepoManager,
            view: baseHomeViewController,
            coordinator: coordinator)
        baseHomeViewController.presenter = basePresnter
        return baseHomeViewController
    }
    
}
