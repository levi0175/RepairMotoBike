//  
//  RegisterContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 26/04/2022.
//

import Foundation

protocol RegisterContract {
    typealias Model = RegisterModelProtocol
    typealias Controller = RegisterControllerProtocol
    typealias View = RegisterViewProtocol
}

protocol RegisterModelProtocol {
    func register(name: String,
                  phone: String,
                  password: String,
                  address: String,
                  age: Int,
                  gender: String,
                  result: @escaping (Result<RegisterViewEntity, String>) -> Void)
}

protocol RegisterControllerProtocol: BaseViewControllerProtocol {
    func set(model: RegisterContract.Model)
}

protocol RegisterViewProtocol {
}
