//
//  SignUpViewControllerConfigrator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 05/12/2022.
//

import UIKit

final class SignUpViewControllerConfigrator {
    
    class func createSignUpView(coordinator: AuthenticationCoordinator!) -> UIViewController {
        let baseViewController = SignUpViewController(viewType: .secondryView)
        let presenter = SignUpVCPresenter(view: baseViewController, coordinator: coordinator)
        baseViewController.presenter = presenter
        return baseViewController
    }
}
