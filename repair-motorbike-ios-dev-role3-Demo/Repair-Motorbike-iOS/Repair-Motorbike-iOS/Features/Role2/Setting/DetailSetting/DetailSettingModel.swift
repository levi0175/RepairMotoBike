//  
//  DetailSettingModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 05/05/2022.
//

import Foundation

struct DetailSettingViewEntity {
    var data: UpdateUserResponse?
}

final class DetailSettingModel {
    
}

extension DetailSettingModel: DetailSettingModelProtocol {
    func changePass(id: Int, passwordSaved: String, newPassword: String, result: @escaping (Result<DetailSettingViewEntity, String>) -> Void) {
        UserAPI.share.changePass(id: id, passwordSaved: passwordSaved, newPassword: newPassword) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(DetailSettingViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
}
