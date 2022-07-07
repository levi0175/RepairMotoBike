//  
//  RegisterStoreContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 18/05/2022.
//

import Foundation

protocol RegisterStoreContract {
    typealias Model = RegisterStoreModelProtocol
    typealias Controller = RegisterStoreControllerProtocol
    typealias View = RegisterStoreViewProtocol
}

protocol RegisterStoreModelProtocol {
    func registerStore(id: Int, data: RegisterStoreRequest, result: @escaping (Result<RegisterStoreViewEntity, ErrorAPI>) -> Void)
}

protocol RegisterStoreControllerProtocol: BaseViewControllerProtocol {
    func set(model: RegisterStoreContract.Model)
}

protocol RegisterStoreViewProtocol {
}
