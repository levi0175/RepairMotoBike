//
//  UserAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation
import Alamofire

protocol UserAPIProtocal {
    func getDataUser(id: Int,
                     result: @escaping (Result<BaseAPI<UserAPIResponse>, ErrorAPI>) -> Void)
    
    func updateUser(id: Int,
                    name: String,
                    gender: String,
                    phone: String,
                    address: String,
                    age: Int,
                    result: @escaping (Result<UpdateUserResponse, ErrorAPI>) -> Void)
    
    func registerStore(id: Int, data: RegisterStoreRequest, result: @escaping (Result<UpdateUserResponse, ErrorAPI>) -> Void)
    
    func changePass(id: Int,
                    passwordSaved: String,
                    newPassword: String,
                    result: @escaping (Result<UpdateUserResponse, ErrorAPI>) -> Void)
}

final class UserAPI: BaseAPIFetcher {
    static let share = UserAPI()
}

extension UserAPI: UserAPIProtocal {
    func changePass(id: Int, passwordSaved: String, newPassword: String, result: @escaping (Result<UpdateUserResponse, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.User.user + "\(id)/" + "password")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = ChangePassRequest(passwordSaved: passwordSaved, newPassword: newPassword)
        request(url: url,
                httpMethod: .post,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: data)
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
    
    func registerStore(id: Int, data: RegisterStoreRequest, result: @escaping (Result<UpdateUserResponse, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Store.newStore + "\(id)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = data
        request(url: url,
                httpMethod: .post,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: data)
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
    
    func getDataUser(id: Int, result: @escaping (Result<BaseAPI<UserAPIResponse>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.User.user + "\(id)/" + "ios")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<UserAPIResponse>.self, from: data)
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
    
    func updateUser(id: Int, name: String, gender: String, phone: String, address: String, age: Int, result: @escaping (Result<UpdateUserResponse, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.User.user + "\(id)/" + "update")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = UpdateUserRequest(name: name, gender: gender, phone: phone, address: address, age: age)
        request(url: url,
                httpMethod: .put,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(UpdateUserResponse.self, from: data)
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
