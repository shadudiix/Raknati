//
//  UIImage+Ext.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 26/11/2022.
//

import UIKit

extension UIImage {
    
    enum baseImagesNames: String {
        case baseLogo = "Logo"
        case emailAddress = "at"
        case password = "lock.fill"
        case resetPassword = "lock.slash"
        case myLocation = "location.fill"
        case settings = "gear"
        case person = "person.crop.circle.fill"
        case darkMode = "moon.circle.fill"
        case notification = "bell.circle.fill"
        case vechile = "car.fill"
    }
    
    static func createBaseImage(_ baseName: baseImagesNames!, _ imageColor: UIColor) -> UIImage? {
        let baseImage = UIImage(systemName: baseName.rawValue)?.withTintColor(imageColor, renderingMode: .alwaysOriginal)
        return baseImage
    }
}
