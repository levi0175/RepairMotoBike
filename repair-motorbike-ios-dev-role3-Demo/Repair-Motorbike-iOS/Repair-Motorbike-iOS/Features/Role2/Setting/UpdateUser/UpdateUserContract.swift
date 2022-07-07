//  
//  UpdateUserContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 26/05/2022.
//

import Foundation

protocol UpdateUserContract {
    typealias Model = UpdateUserModelProtocol
    typealias Controller = UpdateUserControllerProtocol
    typealias View = UpdateUserViewProtocol
}

protocol UpdateUserModelProtocol {
    func updateUser(id: Int, name: String, gender: String, phone: String, address: String, age: Int, result: @escaping (Result<UpdateUserViewEntity, ErrorAPI>) -> Void)
}

protocol UpdateUserControllerProtocol: BaseViewControllerProtocol {
    func set(model: UpdateUserContract.Model)
}

protocol UpdateUserViewProtocol {
}
