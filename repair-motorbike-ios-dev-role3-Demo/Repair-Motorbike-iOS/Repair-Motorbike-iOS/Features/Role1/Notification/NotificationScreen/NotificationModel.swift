//  
//  NotificationModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

struct NotificationViewEntity {
    //  var listAllStoreService: [ListShop] = []
    var services: [DetailShopViewEntity.ListShop] = []
 //   var servicesNill: [DetailGarageAPIResponse] = []
    init(array: [DetailGarageAPIResponse]? = nil) {
        services = array?.map { serviceId in
            DetailShopViewEntity.ListShop(serviceId: serviceId.serviceId, name: serviceId.name, price: serviceId.price, typeVehicle: serviceId.typeVehicle)
        } ?? []
    }
    var dataDeleteService: BaseResponseBoolAPI?
    init (data: BaseResponseBoolAPI) {
        self.dataDeleteService = data
    }
}

final class NotificationModel {
    
}

extension NotificationModel: NotificationModelProtocol {
    func deleteService(idStore: Int, idService: Int, result: @escaping (Result<NotificationViewEntity, String>) -> Void) {
        Role1ServiceAPI.share.deleteService(idStore: idStore, idService: idService) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(NotificationViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    
    func getListService(userId: Int, result: @escaping (Result<NotificationViewEntity, String>) -> Void) {
        Role1ServiceAPI.share.getListService(userId: userId) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(NotificationViewEntity(array: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }

}
