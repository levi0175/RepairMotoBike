//  
//  Role1SettingContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

protocol Role1SettingContract {
    typealias Model = Role1SettingModelProtocol
    typealias Controller = Role1SettingControllerProtocol
    typealias View = Role1SettingViewProtocol
}

protocol Role1SettingModelProtocol {
    func removeToken(result: @escaping () -> Void)
    func getStore(id: Int, result: @escaping (Result<Role1SettingViewEntity, String>) -> Void)
}

protocol Role1SettingControllerProtocol: BaseViewControllerProtocol {
    func set(model: Role1SettingContract.Model)
}

protocol Role1SettingViewProtocol {
}
