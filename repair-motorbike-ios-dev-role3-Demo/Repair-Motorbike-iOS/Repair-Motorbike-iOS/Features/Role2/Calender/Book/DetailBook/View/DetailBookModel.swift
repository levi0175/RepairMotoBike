//  
//  DetailBookModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 05/05/2022.
//

import Foundation

struct DetailBookViewEntity {
    
    // var data: BaseAPI<RegisterAPIResponse>
    var infoCheck: BookingAPIResponse?
    struct DetailBook {
        let code: String
        let success: Bool
        let description: String
        let data: String
        
        init(code: String, success: Bool, description: String?, data: String? ) {
            self.code = code
            self.success = success
            self.description = description ?? ""
            self.data = data ?? ""
        }
        
    }
    let arrList: [DetailBookViewEntity.ListServiceAPI1] = []
    
    struct ListServiceAPI1: Codable {
        let serviceId: Int
        init(serviceId: Int?) {
            self.serviceId = serviceId ?? 1
        }
    }
//    init(array: [ListServiceAPIResponse]? = nil) {
//        self.arrList = array?.map { shop in
//            DetailBookViewEntity.ListServiceAPI1(serviceId: shop.serviceId)
//        } ?? []
//    }
}

final class DetailBookModel {
    
}

extension DetailBookModel: DetailBookModelProtocol {

    func getListBooking(garaId: Int, userId: Int, userName: String, userPhone: String?, timeRepair: String, numberPlate: String?, services: [ListServiceAPIResponse], result: @escaping (Result<DetailBookViewEntity, String>) -> Void) {
        BookingAPI.share.getListBooking(garaId: garaId, userId: userId, userName: userName, userPhone: userPhone ?? "", timeRepair: timeRepair, numberPlate: numberPlate ?? "", services: services) { data in

            switch data {
            case .success(let data):
                result(.success(DetailBookViewEntity(infoCheck: data)))
                
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    
    //    func booking(userName: String, userPhone: String?, timeRepair: String, numberPlate: String?, services: [ServicesIdResponse], result: @escaping(Result<DetailBookViewEntity, String>) -> Void) {
    //        BookingAPI.share.getListBooking(userName: userName, userPhone: userPhone ?? "", timeRepair: timeRepair , numberPlate: numberPlate ?? "", services: []) { data in
    //            switch data {
    //                case .success(let data):
    //                result(.success(DetailBookViewEntity(array: [])))
    //
    //                case .failure(let error):
    //                    result(.failure(error.message))
    //            }
    //        }
    //    }
}
