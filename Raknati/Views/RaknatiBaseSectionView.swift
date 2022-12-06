//
//  RaknatiBaseSectionView.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 29/11/2022.
//

import UIKit

final class RaknatiBaseSectionView: RaknatiBaseUIView {
    
    private lazy var sectionTitle: UILabel = {
        let baseLabel = UILabel()
        baseLabel.textAlignment = .left
        baseLabel.textColor = .secondaryLabel
        baseLabel.font = UIFont.regularFont
        baseLabel.disableAutoResizingMask()
        return baseLabel
    }()
    
    lazy var sectionView: RaknatiBaseUIView = {
        let baseView = RaknatiBaseUIView()
        baseView.backgroundColor = .systemGray6
        return baseView
    }()
    
    init(labelMessage: String!) {
        super.init(frame: CGRect.zero)
        setupView(labelMessage)
    }
    
    private func setupView(_ labelMessage: String!) {

        self.sectionTitle.text = labelMessage
        self.addSubview(sectionTitle)
        let sectionTitleConstraints = [
            sectionTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            sectionTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            sectionTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ]
        NSLayoutConstraint.activate(sectionTitleConstraints)
        
        self.addSubview(sectionView)
        let sectionViewConstraints = [
            sectionView.topAnchor.constraint(equalTo: self.sectionTitle.bottomAnchor, constant: 10),
            sectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            sectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            sectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ]
        NSLayoutConstraint.activate(sectionViewConstraints)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.sectionView.layer.cornerRadius = 6
    }
    
}
