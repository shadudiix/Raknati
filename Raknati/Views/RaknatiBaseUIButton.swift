//
//  RaknatiBaseUIButton.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import UIKit

final class RaknatiBaseUIButton: UIButton {
    
    init() {
        super.init(frame: CGRect.zero)
        setupButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 6
    }
    
    private func setupButton() {
        self.disableAutoResizingMask()
        let paddingSpace = 15.00
        let backgroundColor: UIColor = .systemYellow
        let tintColor: UIColor = .black
        self.titleLabel?.font = .regularFont
        if #available(iOS 15.0, *) {
            var buttonConfiguration = UIButton.Configuration.filled()
            buttonConfiguration.contentInsets = NSDirectionalEdgeInsets(
                top: paddingSpace, leading: paddingSpace,
                bottom: paddingSpace, trailing: paddingSpace
            )
            buttonConfiguration.baseBackgroundColor = backgroundColor
            buttonConfiguration.baseForegroundColor = tintColor
            self.configuration = buttonConfiguration
        } else {
            self.contentEdgeInsets = .init(
                top: paddingSpace, left: paddingSpace,
                bottom: paddingSpace, right: paddingSpace
            )
            self.backgroundColor = backgroundColor
            self.tintColor = tintColor
        }
        self.layer.shadowColor = backgroundColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.5
    }
}
