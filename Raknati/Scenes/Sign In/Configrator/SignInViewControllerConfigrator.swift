//
//  SignInViewControllerConfigrator.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import UIKit

final class SignInViewControllerConfigrator {
    
    class func createSignInVC(coordinator: AuthenticationCoordinator!) -> UIViewController {
        let signInVC = SignInViewController(viewType: .secondryView)
        let signInPreseneter = SignInVCPresenter(view: signInVC, coordinator: coordinator)
        signInVC.presenter = signInPreseneter
        return signInVC
    }
    
}
