//  
//  LoginContract.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

protocol LoginContract {
    typealias Model = LoginModelProtocol
    typealias Controller = LoginControllerProtocol
    typealias View = LoginViewProtocol
}

protocol LoginModelProtocol {
    func login(phone: String,
               password: String,
               result: @escaping (Result<LoginViewEntity, String>) -> Void)
}

protocol LoginControllerProtocol: BaseViewControllerProtocol {
    func set(model: LoginContract.Model)
}

protocol LoginViewProtocol {
}
