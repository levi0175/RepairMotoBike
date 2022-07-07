//
//  AppPreferences.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

final class AppPreferences {
    static let shared: AppPreferences = AppPreferences()
    private let keychain: KeychainWrapper = KeychainWrapper()
    var language: EnumConstant.Language = .vietnamese

    func getLanguage() {
        if let languageValue = UserDefaults.standard.string(forKey: NameConstant.UserDefaults.Language) {
            language = EnumConstant.Language(rawValue: languageValue) ?? .english
        } else {
            language = EnumConstant.Language(rawValue: Locale.current.languageCode ?? "") ?? .english
        }
    }

    func setLanguage(_ value: EnumConstant.Language) {
        UserDefaults.standard.set(value.rawValue, forKey: NameConstant.UserDefaults.Language)
        language = value
    }

    func setToken(_ token: String) {
        do {
            try keychain.setValue(token, for: NameConstant.Keychain.Token)
        } catch let error {
            Logger.error(error.localizedDescription)
        }
    }

    func getToken() -> String? {
        do {
            let token = try keychain.getValue(for: NameConstant.Keychain.Token)
            return token
        } catch let error {
            Logger.error(error.localizedDescription)
            return nil
        }
    }

    func removeToken() {
        do {
            try keychain.removeValue(for: NameConstant.Keychain.Token)
        } catch let error {
            Logger.error(error.localizedDescription)
        }
    }
}
