//  
//  UpdateUserModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 26/05/2022.
//

import Foundation

struct UpdateUserViewEntity {
    var data: UpdateUserResponse?
}

final class UpdateUserModel {
    
}

extension UpdateUserModel: UpdateUserModelProtocol {
    func updateUser(id: Int, name: String, gender: String, phone: String, address: String, age: Int, result: @escaping (Result<UpdateUserViewEntity, ErrorAPI>) -> Void) {
        UserAPI.share.updateUser(id: id, name: name, gender: gender, phone: phone, address: address, age: age) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(UpdateUserViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func login(phone: String,
               password: String,
               result: @escaping (Result<LoginViewEntity, String>) -> Void) {
        AuthenticateAPI.share.login(phone: phone,
                                    password: password) { dataResult in
            switch dataResult {
            case .success(let data):
                
                AppPreferences.shared.setToken(data.data?.accessToken ?? "")
                result(.success(LoginViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
}
