//  
//  AllBookingModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

struct AllBookingViewEntity {
    var dataBooking: BaseResponseBoolAPI?
    struct Role1ListBooking: Codable {
        let bookingId: Int
        let userName: String?
        let phoneUser: String?
        let storeName: String?
        let timeRepair: String?
        let numberPlate: String?
        let serviceDTOList: [ListServiceAPI]
        let created_time: String?
    }
    struct ListServiceAPI: Codable {
        let serviceId: Int?
        let name: String?
        let price: Double?
        let typeVehicle: String?
        init(serviceId: Int?, name: String?, price: Double?, typeVehicle: String?) {
            self.serviceId = serviceId ?? 1
            self.name = name ?? ""
            self.price = price ?? 10.0
            self.typeVehicle = typeVehicle ?? ""
        }
    }
    init (dataBooking: BaseResponseBoolAPI) {
        self.dataBooking = dataBooking
    }
    var listData: [AllBookingViewEntity.Role1ListBooking] = []
    var listService: [AllBookingViewEntity.ListServiceAPI] = []
    init(array: [ListBookingResponse]? = nil) {
        self.listData = array?.map { shop in
            AllBookingViewEntity.Role1ListBooking(bookingId: shop.bookingId,
                                                  userName: shop.userName,
                                                  phoneUser: shop.phoneUser,
                                                  storeName: shop.storeName,
                                                  timeRepair: shop.timeRepair,
                                                  numberPlate: shop.numberPlate,
                                                  serviceDTOList: shop.serviceDTOList.map { servicee in
                AllBookingViewEntity.ListServiceAPI(serviceId: servicee.serviceId, name: servicee.name, price: servicee.price, typeVehicle: servicee.typeVehicle)
            }, created_time: shop.created_time)
            
        } ?? []
    }
}

final class AllBookingModel {
    
}

extension AllBookingModel: AllBookingModelProtocol {
    func deleteBooking(idBooking: Int, result: @escaping (Result<AllBookingViewEntity, String>) -> Void) {
        Role1ListBookingAPI.share.deleteBooking(idBooking: idBooking) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(AllBookingViewEntity(dataBooking: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    
    func confirmBooking(idStore: Int, booking: Int, result: @escaping (Result<AllBookingViewEntity, String>) -> Void) {
        Role1ListBookingAPI.share.comfirmBooking(idStore: idStore, booking: booking) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(AllBookingViewEntity(dataBooking: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    
    func getListBookAll(idStore: Int, result: @escaping (Result<AllBookingViewEntity, String>) -> Void) {
        Role1ListBookingAPI.share.getListBookAll(idStore: idStore) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(AllBookingViewEntity(array: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    
    func getListBook(idStore: Int, startDate: String, endDate: String, result: @escaping (Result<AllBookingViewEntity, String>) -> Void) {
        Role1ListBookingAPI.share.getListBook(idStore: idStore, startDate: startDate, endDate: endDate) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(AllBookingViewEntity(array: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
  
}
