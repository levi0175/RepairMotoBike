//  
//  LoginModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//
import Foundation

struct LoginViewEntity {
    var data: BaseAPI<AuthenticateAPIResponse>
}

final class LoginModel {
}

extension LoginModel: LoginModelProtocol {
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
