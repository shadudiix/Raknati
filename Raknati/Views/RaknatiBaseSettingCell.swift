//
//  RaknatiBaseSettingCell.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import UIKit

final class RaknatiBaseSettingCell: RaknatiBaseUIView {
    
    private lazy var logoImageView: UIImageView = {
        let baseImageView = UIImageView()
        baseImageView.disableAutoResizingMask()
        return baseImageView
    }()
    
    private lazy var cellText: UILabel = {
        let baseLabel = UILabel()
        baseLabel.disableAutoResizingMask()
        baseLabel.font = .regularFont
        baseLabel.textColor = .label
        baseLabel.setContentHuggingPriority(.required, for: .vertical)
        baseLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        return baseLabel
    }()
    
    lazy var switchButton: RaknatiBaseUISwitch = {
        let baseSwitchButton = RaknatiBaseUISwitch(isON: true)
        return baseSwitchButton
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupCell()
    }
    
    private func setupCell() {
        
        self.addSubview(logoImageView)
        let logoImageViewConstraints = [
            logoImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            logoImageView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            logoImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 32)
        ]
        NSLayoutConstraint.activate(logoImageViewConstraints)
        
        self.addSubview(cellText)
        let cellTextConstraints = [
            cellText.topAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            cellText.bottomAnchor.constraint(greaterThanOrEqualTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            cellText.leadingAnchor.constraint(equalTo: self.logoImageView.trailingAnchor, constant: 5),
            cellText.centerYAnchor.constraint(equalTo: self.logoImageView.centerYAnchor),
        ]
        NSLayoutConstraint.activate(cellTextConstraints)
        
        self.addSubview(switchButton)
        let switchButtonConstraints = [
            switchButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 5),
            switchButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            switchButton.leadingAnchor.constraint(equalTo: self.cellText.trailingAnchor, constant: 5),
            switchButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -5)
        ]
        NSLayoutConstraint.activate(switchButtonConstraints)
    }
    
    func setImage(_ imageBaseName: UIImage.baseImagesNames!, imageColor: UIColor = .systemBlue) {
        self.logoImageView.image = UIImage.createBaseImage(imageBaseName, imageColor)
    }
    
    func setTitle(_ title: String!) {
        self.cellText.text = title
    }
    
}
