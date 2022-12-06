//
//  ResetPasswordViewDelegates.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import Foundation

protocol ResetPasswordViewDelegates: AnyObject {
    var presenter: ResetPasswordVCPresenter! { get set }
    var emailAddress: String? { get }
}

typealias ResetPasswordDelegates = ResetPasswordViewDelegates & BaseViewControllerDelegates
