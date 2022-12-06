//
//  RaknatiBaseUITextField.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 27/11/2022.
//

import UIKit

final class RaknatiBaseUITextField: UITextField {
    
    private var padding: UIEdgeInsets {
        var basePadding = UIEdgeInsets()
        basePadding.top = 15
        basePadding.bottom = 15
        basePadding.right = 35
        if(self.leftViewMode == .always) { basePadding.left = 35 } else { basePadding.left = 15 }
        return basePadding
    }
    
    override func borderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        let clearButtonRect = super.clearButtonRect(forBounds: bounds)
        return clearButtonRect.offsetBy(dx: -10, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let leftViewRect = super.leftViewRect(forBounds: bounds)
        return leftViewRect.offsetBy(dx: 10, dy: 0)
    }
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rightViewRect = super.rightViewRect(forBounds: bounds)
        return rightViewRect.offsetBy(dx: -15, dy: 0)
    }
    
    init() {
        super.init(frame: CGRect.zero)
        setupTextField()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTextField() {
        
        self.font = .lightFont
        self.disableAutoResizingMask()
        self.backgroundColor = .systemGray5
        self.tintColor = .systemYellow
        self.clearButtonMode = .whileEditing
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 6
    }
    
    func setPlaceHolder(_ placeHolder: String!) {
        self.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [.foregroundColor : UIColor.secondaryLabel])
    }
    
    func setLeftImageView(_ imageName: UIImage.baseImagesNames!) {
        guard let baseImage = UIImage.createBaseImage(imageName, .systemGray2) else { return }
        let baseImageView = UIImageView(image: baseImage)
        self.leftView = baseImageView
        self.leftViewMode = .always
    }
    
    func setRightImageView(_ imageName: UIImage.baseImagesNames!) {
        guard let baseImage = UIImage.createBaseImage(imageName, .systemGray2) else { return }
        let baseImageView = UIImageView(image: baseImage)
        self.rightView = baseImageView
        self.rightViewMode = .unlessEditing
    }
    
}
