//
//  Role1ServiceAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 06/06/2022.
//

import Foundation
protocol Role1ServiceAPIProtocal {
    func getListService(userId: Int, result: @escaping (Result<BaseAPI<[DetailGarageAPIResponse]>, ErrorAPI>) -> Void)
    func postService(userId: Int, name: String, price: Double, typeVehicle: String, result: @escaping (Result<EvaluateAPIReponse, ErrorAPI>) -> Void)
    func updateService(userId: Int, serviceId: Int, name: String, price: Double, typeVehicle: String, result: @escaping (Result<EvaluateAPIReponse, ErrorAPI>) -> Void)
    func deleteService(idStore: Int, idService: Int, result: @escaping (Result<BaseResponseBoolAPI, ErrorAPI>) -> Void)
}
final class Role1ServiceAPI: BaseAPIFetcher {
    static let share = Role1ServiceAPI()
    
}
extension Role1ServiceAPI: Role1ServiceAPIProtocal {
    func getListService(userId: Int, result: @escaping (Result<BaseAPI<[DetailGarageAPIResponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/stores/listSevrices/\(userId)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[DetailGarageAPIResponse]>.self, from: data)
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
    func postService(userId: Int, name: String, price: Double, typeVehicle: String, result: @escaping (Result<EvaluateAPIReponse, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/stores/additionService/\(userId)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = AddServicesRequest(name: name, price: price, typeVehicle: typeVehicle)
        request(url: url,
                httpMethod: .post,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
              //  print("data:", String(decoding: data, as: UTF8.self))
                guard let dataResponse = try? JSONDecoder().decode(EvaluateAPIReponse.self, from: data)
                else {
                    result(.failure(ErrorAPI(status: 7, message: ResponseError.unableToDecode.rawValue)))
                    return
                }
                result(.success(dataResponse))
            case .failure(let error):
                print(error)
                result(.failure(error))
            }
        }
    }
    func deleteService(idStore: Int, idService: Int, result: @escaping (Result<BaseResponseBoolAPI, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/stores/\(idStore)/deleting/\(idService)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .delete) { dataResult in
            switch dataResult {
            case .success(let data):
                print("data:", String(decoding: data, as: UTF8.self))
                guard let dataResponse = try? JSONDecoder().decode(BaseResponseBoolAPI.self, from: data)
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
    func updateService(userId: Int, serviceId: Int, name: String, price: Double, typeVehicle: String, result: @escaping (Result<EvaluateAPIReponse, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/stores/\(userId)/updating/\(serviceId)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = AddServicesRequest(name: name, price: price, typeVehicle: typeVehicle)
        request(url: url,
                httpMethod: .put,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(EvaluateAPIReponse.self, from: data)
                else {
                    result(.failure(ErrorAPI(status: 7, message: ResponseError.unableToDecode.rawValue)))
                    return
                }
                result(.success(dataResponse))
            case .failure(let error):
                print(error)
                result(.failure(error))
            }
        }
    }
}
