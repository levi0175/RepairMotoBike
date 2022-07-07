//
//  BookingAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 25/05/2022.
//

import Foundation

protocol BookAPIProtocal {
   // func getListShop(result: @escaping (Result<BaseAPI<[ShopAPIResponse1]>, ErrorAPI>) -> Void)

    func getListBooking(garaId: Int, userId: Int, userName: String, userPhone: String, timeRepair: String, numberPlate: String, services: [ListServiceAPIResponse], result: @escaping (Result<BookingAPIResponse, ErrorAPI>) -> Void)

}
final class BookingAPI: BaseAPIFetcher {
    static let share = BookingAPI()

}
extension BookingAPI: BookAPIProtocal {

    func getListBooking(garaId: Int, userId: Int, userName: String, userPhone: String, timeRepair: String, numberPlate: String, services: [ListServiceAPIResponse], result: @escaping (Result<BookingAPIResponse, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/bookings/\(garaId)/users/\(userId)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = BookingAPIRequest(userName: userName, userPhone: userPhone, timeRepair: timeRepair, numberPlate: numberPlate, services: services)
        request(url: url,
                httpMethod: .post,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
                print("data:", String(decoding: data, as: UTF8.self))
                guard let dataResponse = try? JSONDecoder().decode(BookingAPIResponse.self, from: data)
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
