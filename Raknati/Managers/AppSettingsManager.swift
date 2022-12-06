//
//  AppSettingsManager.swift
//  Raknati
//
//  Created by Shady K. Maadawy on 04/12/2022.
//

import Foundation

final class AppSettingsManager {
    
    // MARK: - Static Properties
    
    static let shared = AppSettingsManager()
    
    private let userDefaults = UserDefaults.standard
    
    private struct SettingsKeys {
        static let darkModeKey = "DarkMode"
        static let pushNotificationKey = "NotifcationsEnabled"
    }
    // MARK: - Properties
    
    var darkModeIsON: Bool {
        get {
            let rawValue = self.userDefaults.bool(forKey: SettingsKeys.darkModeKey)
            return rawValue
        } set {
            userDefaults.set(newValue, forKey: SettingsKeys.darkModeKey)
        }
    }
    
    var pushNotificationsIsON: Bool {
        get {
            let rawValue = self.userDefaults.bool(forKey: SettingsKeys.pushNotificationKey)
            return rawValue
        } set {
            userDefaults.set(newValue, forKey: SettingsKeys.pushNotificationKey)
        }
    }
    
    // MARK: - Object Life Cycle / Singleton
    
    private init() {}
    
}
