//  
//  SettingContract.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

protocol SettingContract {
    typealias Model = SettingModelProtocol
    typealias Controller = SettingControllerProtocol
    typealias View = SettingViewProtocol
}

protocol SettingModelProtocol {
    func removeToken(result: @escaping () -> Void)
    func getUser(id: Int, result: @escaping (Result<SettingViewEntity, String>) -> Void)
}

protocol SettingControllerProtocol: BaseViewControllerProtocol {
    func set(model: SettingContract.Model)
}

protocol SettingViewProtocol {
}
