//
//  BookedAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 27/05/2022.
//

import Foundation
protocol BookedAPIProtocal {
    func getListBooked(userId: Int, result: @escaping (Result<BaseAPI<[BookedReponse]>, ErrorAPI>) -> Void)
    func getListBookedSuccess(userId: Int, result: @escaping (Result<BaseAPI<[BookedSuccessReponse]>, ErrorAPI>) -> Void)
}
final class BookedAPI: BaseAPIFetcher {
    static let share = BookedAPI()
}

extension BookedAPI: BookedAPIProtocal {
    func getListBooked(userId: Int, result: @escaping (Result<BaseAPI<[BookedReponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/users/\(userId)/bookings")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                print("data:", String(decoding: data, as: UTF8.self))
      
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[BookedReponse]>.self, from: data)
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

    func getListBookedSuccess(userId: Int, result: @escaping (Result<BaseAPI<[BookedSuccessReponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/users/\(userId)/bills")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                print("data:", String(decoding: data, as: UTF8.self))
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[BookedSuccessReponse]>.self, from: data)
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
