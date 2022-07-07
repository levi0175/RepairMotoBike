//  
//  RegisterStoreModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 18/05/2022.
//

import Foundation

struct RegisterStoreViewEntity {
    var data: UpdateUserResponse?
}

final class RegisterStoreModel {
    
}

extension RegisterStoreModel: RegisterStoreModelProtocol {
    func registerStore(id: Int, data: RegisterStoreRequest, result: @escaping (Result<RegisterStoreViewEntity, ErrorAPI>) -> Void) {
        UserAPI.share.registerStore(id: id, data: data) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(RegisterStoreViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
}
