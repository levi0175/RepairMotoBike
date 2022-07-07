//  
//  ScheduleModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 07/05/2022.
//

import Foundation

struct ScheduleViewEntity {
    struct ListBookedSuccess: Decodable, Encodable {
        let userName: String
        let phoneUser: String?
        let storeName: String?
        let timeRepair: String?
        let numberPlate: String?
        let serviceDTOList: [HomeGarageViewEntity.ServiceListGaraHung]
        let created_time: String?
    }
    struct ListBooked: Decodable, Encodable {
        let bookingId: Int
        let userName: String?
        let phoneUser: String?
        let storeName: String?
        let timeRepair: String?
        let numberPlate: String?
        let serviceDTOList: [HomeGarageViewEntity.ServiceListGaraHung]
        let created_time: String?
    }
//    struct DetailGarageAPIResponse: Decodable, Encodable {
//        let serviceId: Int
//        let name: String?
//        let price: Double?
//        let typeVehicle: String?
//        init(serviceId: Int?, name: String?, price: Double?, typeVehicle: String?) {
//            self.serviceId = serviceId ?? 1
//            self.name = name ?? ""
//            self.price = price ?? 0.0
//            self.typeVehicle = typeVehicle ?? ""
//        }
//    }
    var data: [ScheduleViewEntity.ListBooked] = []
    var dataSuccess: [ScheduleViewEntity.ListBookedSuccess] = []
    init(array: [BookedReponse]? = nil) {
        self.data = array?.map { shop in
            ScheduleViewEntity.ListBooked(bookingId: shop.bookingId,
                                          userName: shop.userName,
                                          phoneUser: shop.phoneUser,
                                          storeName: shop.storeName,
                                          timeRepair: shop.timeRepair,
                                          numberPlate: shop.numberPlate,
                                          serviceDTOList: shop.serviceDTOList.map { item in
                HomeGarageViewEntity.ServiceListGaraHung(serviceId: item.serviceId, name: item.name, price: item.price, typeVehicle: item.typeVehicle)
            }, created_time: shop.created_time)
        } ?? []
      
    }
    
    init(arraySuccess: [BookedSuccessReponse]? = nil) {
        self.dataSuccess = arraySuccess?.map { shop in
            ScheduleViewEntity.ListBookedSuccess(userName: shop.userName, phoneUser: shop.phoneUser, storeName: shop.storeName, timeRepair: shop.timeRepair, numberPlate: shop.numberPlate, serviceDTOList: shop.serviceDTOList.map { item in
                HomeGarageViewEntity.ServiceListGaraHung(serviceId: item.serviceId, name: item.name, price: item.price, typeVehicle: item.typeVehicle)
            }, created_time: shop.created_time)
        } ?? []
      
    }
}

final class ScheduleModel {
    
}

extension ScheduleModel: ScheduleModelProtocol {
    func getListBooked(userId: Int, result: @escaping (Result<ScheduleViewEntity, String>) -> Void) {
        BookedAPI.share.getListBooked(userId: userId) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(ScheduleViewEntity(array: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    func getListBookedSuccess(userId: Int, result: @escaping (Result<ScheduleViewEntity, String>) -> Void) {
        BookedAPI.share.getListBookedSuccess(userId: userId) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(ScheduleViewEntity(arraySuccess: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
}
