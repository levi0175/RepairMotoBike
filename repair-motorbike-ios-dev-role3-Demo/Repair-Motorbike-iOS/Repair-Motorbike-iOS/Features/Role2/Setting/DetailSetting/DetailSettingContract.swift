//  
//  DetailSettingContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 05/05/2022.
//

import Foundation

protocol DetailSettingContract {
    typealias Model = DetailSettingModelProtocol
    typealias Controller = DetailSettingControllerProtocol
    typealias View = DetailSettingViewProtocol
}

protocol DetailSettingModelProtocol {
    func changePass(id: Int, passwordSaved: String, newPassword: String, result: @escaping (Result<DetailSettingViewEntity, String>) -> Void)
}

protocol DetailSettingControllerProtocol: BaseViewControllerProtocol {
    func set(model: DetailSettingContract.Model)
}

protocol DetailSettingViewProtocol {
}
