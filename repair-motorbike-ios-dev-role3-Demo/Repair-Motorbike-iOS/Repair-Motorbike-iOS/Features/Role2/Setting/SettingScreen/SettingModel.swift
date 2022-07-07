//  
//  SettingModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

struct SettingViewEntity {
    var data: UserAPIResponse?
    
    struct Setting {
        static let nameSetting: [String] = ["Thông tin cá nhân", "Số điện thoại", "Ngôn ngữ", "Thay đổi mật khẩu", "Đăng ký cửa hàng"]
    }
}

final class SettingModel {

}

extension SettingModel: SettingModelProtocol {
    func getUser(id: Int, result: @escaping (Result<SettingViewEntity, String>) -> Void) {
        UserAPI.share.getDataUser(id: id) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(SettingViewEntity(data: data.data)))
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
