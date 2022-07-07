//
//  Role1ListBookingAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 02/06/2022.
//

import Foundation
protocol Role1ListBookingAPIProtocal {
    func getListBook(idStore: Int, startDate: String, endDate: String, result: @escaping (Result<BaseAPI<[ListBookingResponse]>, ErrorAPI>) -> Void)
    func getListBookAll(idStore: Int, result: @escaping (Result<BaseAPI<[ListBookingResponse]>, ErrorAPI>) -> Void)
    func comfirmBooking(idStore: Int, booking: Int, result: @escaping (Result<BaseResponseBoolAPI, ErrorAPI>) -> Void)
    func deleteBooking(idBooking: Int, result: @escaping (Result<BaseResponseBoolAPI, ErrorAPI>) -> Void)
}
final class Role1ListBookingAPI: BaseAPIFetcher {
    static let share = Role1ListBookingAPI()
}

extension Role1ListBookingAPI: Role1ListBookingAPIProtocal {
    func deleteBooking(idBooking: Int, result: @escaping (Result<BaseResponseBoolAPI, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/bookings/\(idBooking)/deletion")
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
    
    func getListBookAll(idStore: Int, result: @escaping (Result<BaseAPI<[ListBookingResponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/stores/\(idStore)/bookings")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[ListBookingResponse]>.self, from: data)
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
    
    func getListBook(idStore: Int, startDate: String, endDate: String, result: @escaping (Result<BaseAPI<[ListBookingResponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/stores/\(idStore)/bookings?startDate=\(startDate)&endDate=\(endDate)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                print("data:", String(decoding: data, as: UTF8.self))
      
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[ListBookingResponse]>.self, from: data)
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
    func comfirmBooking(idStore: Int, booking: Int, result: @escaping (Result<BaseResponseBoolAPI, ErrorAPI>) -> Void) {
            guard let url = apiURL("v1/stores/\(idStore)/bookings/\(booking)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .put) { dataResult in
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

}
