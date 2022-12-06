//
//  SettingsVCDelegates.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import Foundation

protocol ِAppSettingsVCDelegates: AnyObject {
    var presenter: AppSettingsVCPresenter! { get set }
    func setNameLabel(_ name: String!)
    func setEmailVerifiedLabel(_ labelText: String!)
    func setDarkMode(_ isOn: Bool)
}

typealias AppSettingsViewDelegates = ِAppSettingsVCDelegates & BaseViewControllerDelegates
