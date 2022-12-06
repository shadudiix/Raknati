//
//  AppSettingsViewControllerConfigrator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import UIKit

final class AppSettingsViewControllerConfigrator {
    
    class func createAppSettingsVC(coordinator: HomeCoordinator!, delegates: HomePresenterDelgates!) -> UIViewController {
        let baseViewController = AppSettingsViewController(viewType: .secondryView)
        let basePresnter = AppSettingsVCPresenter(view: baseViewController, coordinator: coordinator, delegates: delegates)
        baseViewController.presenter = basePresnter
        return baseViewController
    }
}
