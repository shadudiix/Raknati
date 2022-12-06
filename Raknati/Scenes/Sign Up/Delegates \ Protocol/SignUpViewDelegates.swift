//
//  SignUpViewDelegates.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 05/12/2022.
//

import Foundation

protocol SignUpViewDelegates: AnyObject {
    var presenter: SignUpVCPresenter! { get set }
    var displayName: String? { get }
    var emailAddress: String? { get }
    var securePassword: String? { get }
}

typealias SignUpVCDelegates = SignUpViewDelegates & BaseViewControllerDelegates

