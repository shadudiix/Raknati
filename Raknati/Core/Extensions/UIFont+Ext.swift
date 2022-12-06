//
//  UIFont+Ext.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 24/11/2022.
//

import UIKit

extension UIFont {
    
    static var extraLightFont: UIFont! {
        return getFont(fontName: "Poppins-ExtraLight", fontSize: 13)
    }
    
    static var lightFont: UIFont! {
        return getFont(fontName: "Poppins-Light", fontSize: 15)
    }

    static var regularFont: UIFont! {
        return getFont(fontName: "Poppins-Regular", fontSize: 16)
    }
    
    static var semiBoldFont: UIFont! {
        return getFont(fontName: "Poppins-SemiBold", fontSize: 20)
    }
    
    static var boldFont: UIFont! {
        return getFont(fontName: "Poppins-Bold", fontSize: 24)
    }
    
    static func getFont(fontName: String, fontSize: CGFloat) -> UIFont {
        guard let customFont = UIFont(name: fontName, size: fontSize) else {
            fatalError("Failed to load \(fontName) font.")
        }
        return UIFontMetrics.default.scaledFont(for: customFont)
    }
}
