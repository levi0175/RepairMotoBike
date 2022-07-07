//
//  AuthenticateAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

protocol AuthenticateAPIProtocal {
    func login(phone: String,
               password: String,
               result: @escaping (Result<BaseAPI<AuthenticateAPIResponse>, ErrorAPI>) -> Void)
    
    func register(phone: String,
                  password: String,
                  address: String,
                  name: String,
                  age: Int,
                  gender: String,
                  result: @escaping (Result<BaseAPI<RegisterAPIResponse>, ErrorAPI>) -> Void)
}

final class AuthenticateAPI: BaseAPIFetcher {
    static let share = AuthenticateAPI()
}

extension AuthenticateAPI: AuthenticateAPIProtocal {
    func register(phone: String, password: String, address: String, name: String, age: Int, gender: String, result: @escaping (Result<BaseAPI<RegisterAPIResponse>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Authenticate.register)
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = RegisterAPIRequest(phone: phone, password: password, address: address, name: name, age: age, gender: gender)
        request(url: url,
                httpMethod: .post,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<RegisterAPIResponse>.self, from: data)
                else {
                    result(.failure(ErrorAPI(status: 7, message: ResponseError.unableToDecode.rawValue)))
                    return
                }
                result(.success(dataResponse))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
    func login(phone: String,
               password: String,
               result: @escaping (Result<BaseAPI<AuthenticateAPIResponse>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Authenticate.login)
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = LoginAPIRequest(phone: phone, password: password)
        request(url: url,
                httpMethod: .post,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):

                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<AuthenticateAPIResponse>.self, from: data)
                else {
                    result(.failure(ErrorAPI(status: 7, message: ResponseError.unableToDecode.rawValue)))
                    return
                }
                result(.success(dataResponse))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
}
