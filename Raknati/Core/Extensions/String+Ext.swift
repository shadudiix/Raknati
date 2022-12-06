//
//  String+Ext.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 05/12/2022.
//

import Foundation

extension String {
    
    enum RegexBuffer: String {
        case displayName = "^.{8,48}$"
        case emailAddress = "[[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]]{5,64}"
        case securePassword = "^.{6,48}$"
    }

    func validateString(_ regexBuffer: RegexBuffer!) -> Bool {
        let regaxPredicate = NSPredicate(format:"SELF MATCHES %@", regexBuffer.rawValue)
        return regaxPredicate.evaluate(with: self)
    }
}
