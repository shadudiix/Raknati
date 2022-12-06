//
//  ResetPasswordViewControllerConfigrator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import UIKit

final class ResetPasswordViewControllerConfigrator {
    
    class func createResetVC(coordinator: AuthenticationCoordinator!) -> UIViewController {
        let baseViewController = ResetPasswordViewController(viewType: .secondryView)
        let presenter = ResetPasswordVCPresenter(view: baseViewController, coordinator: coordinator)
        baseViewController.presenter = presenter
        return baseViewController
    }
    
}

