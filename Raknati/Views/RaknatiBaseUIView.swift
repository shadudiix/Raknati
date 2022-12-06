//
//  RaknatiBaseUIView.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import UIKit

class RaknatiBaseUIView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUIView()
    }
    
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.endEditing(true)
    }
    
    private func setupUIView() {
        self.disableAutoResizingMask()
    }
    
}
