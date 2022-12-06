//
//  SignInViewDelegates.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import Foundation

protocol SignInViewDelegates: AnyObject {
    var presenter: SignInVCPresenter! { get set }
    var emailAddress: String? { get }
    var securePassword: String? { get }
}

typealias SignInDelegates = BaseViewControllerDelegates & SignInViewDelegates
