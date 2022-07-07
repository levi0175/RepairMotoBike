//  
//  Role1SettingModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

struct Role1SettingViewEntity {
    var data: StoreAPIResponse?
    
    struct Setting {
        static let nameSetting: [String] = ["Tên cửa hàng", "Số điện thoại", "Địa chỉ", "Đánh giá", "Chỉnh sửa dịch vụ"]
    }
}

final class Role1SettingModel {
    
}

extension Role1SettingModel: Role1SettingModelProtocol {
    func getStore(id: Int, result: @escaping (Result<Role1SettingViewEntity, String>) -> Void) {
        StoreAPI.share.getDataStore(id: id) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(Role1SettingViewEntity(data: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    
    func removeToken(result: @escaping () -> Void) {
        AppPreferences.shared.removeToken()
        result()
    }
}
