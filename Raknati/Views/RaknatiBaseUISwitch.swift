//
//  RaknatiBaseUISwitch.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import UIKit

protocol UISwitchStatus: AnyObject {
    var buttonIsOn: Bool! { get }
}

final class RaknatiBaseUISwitch: UISwitch, UISwitchStatus {
    
    init(isON: Bool!) {
        super.init(frame: CGRect.zero)
        setupUISwitch(isON)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUISwitch(_ isON: Bool!) {
        self.disableAutoResizingMask()
        self.isOn = isON
        self.onTintColor = .systemYellow
    }
    
    func setIsON(_ isON: Bool!) {
        self.isOn = isOn
    }
    
    var buttonIsOn: Bool! {
        return self.isOn
    }
}
