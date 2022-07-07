//  
//  RegisterModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 26/04/2022.
//

import Foundation

struct RegisterViewEntity {
    var data: BaseAPI<RegisterAPIResponse>
}

final class RegisterModel {    
}

extension RegisterModel: RegisterModelProtocol {
    func register(name: String, phone: String, password: String, address: String, age: Int, gender: String, result: @escaping (Result<RegisterViewEntity, String>) -> Void) {
        AuthenticateAPI.share.register(phone: phone, password: password, address: address, name: name, age: age, gender: gender) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(RegisterViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
}
