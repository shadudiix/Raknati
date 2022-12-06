//
//  BaseErrorCodes.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 05/12/2022.
//

import Foundation

enum RaknatiErrorCodes: LocalizedError, Error {
    
    case anErrorOccurred
    case failedToFetch
    case dataIsInvaild
    case failedToParse
    case emptyCollection
    case displayName
    case emailAddressError
    case passwordError

    var errorDescription: String? {
        switch(self) {
            case .anErrorOccurred:
                    return "An error occurred, please try again."
            case .failedToFetch:
                    return "Failed to fetch data from server."
            case .dataIsInvaild:
                    return "Data received from server is invaild."
            case .failedToParse:
                    return "Failed to parse data from json."
            case .emptyCollection:
                    return ""
            case .displayName:
                    return "display name cannot be more than 48 characters or less than 8."
            case .emailAddressError:
                    return "Email Address cannot be more than 64 characters or less than 4."
            case .passwordError:
                    return "Password cannot be more than 48 characters or less than 6."
        }
    }
}


