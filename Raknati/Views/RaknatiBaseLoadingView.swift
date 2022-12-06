//
//  RaknatiBaseLoadingView.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 28/11/2022.
//

import UIKit

final class RaknatiBaseLoadingView: RaknatiBaseUIView {
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let baseView = UIActivityIndicatorView()
        baseView.style = .large
        baseView.color = .white
        baseView.disableAutoResizingMask()
        return baseView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupBaseView()
    }
    
    private func setupBaseView() {
        
        self.backgroundColor = .black.withAlphaComponent(0.4)
        
        self.addSubview(loadingIndicator)
        let loadingIndicatorConstraints = [
            loadingIndicator.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            loadingIndicator.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 25),
            loadingIndicator.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -25),
            loadingIndicator.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 25),
            loadingIndicator.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -25),
        ]
        NSLayoutConstraint.activate(loadingIndicatorConstraints)
        loadingIndicator.startAnimating()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 6
    }
    
}
