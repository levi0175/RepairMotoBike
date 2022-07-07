//  
//  HomeGarageModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 21/05/2022.
//

import Foundation

struct HomeGarageViewEntity {
    struct ListGarage1: Decodable, Encodable {
        let storeId: Int
        let name: String?
        let address: String?
        let phone: String?
        let status: Int?
        var serviceList: [ServiceListGaraHung]
        var comments: [CommentsHung]
       
    }
    struct ServiceListGaraHung: Decodable, Encodable {
        let serviceId: Int?
        let name: String?
        let price: Double?
        let typeVehicle: String?
        var check: Bool = false
        
        init(serviceId: Int?, name: String?, price: Double?, typeVehicle: String?) {
            self.serviceId = serviceId ?? 1
            self.name = name ?? ""
            self.price = price ?? 10.0
            self.typeVehicle = typeVehicle ?? ""
        }
    }
    struct CommentsHung: Encodable, Decodable {
        let numberStar: Int
        let content: String?
        let createdTime: String?
        init(numberStar: Int, content: String?, createdTime: String?) {
            self.numberStar = numberStar
            self.content = content ?? ""
            self.createdTime = createdTime ?? ""
        }
    }
    
    var listGara: [HomeGarageViewEntity.ListGarage1] = []
    var listComment: [HomeGarageViewEntity.CommentsHung] = []
    var listService: [HomeGarageViewEntity.ServiceListGaraHung] = []
    init(array: [ShopAPIResponse1]? = nil) {
        self.listGara = array?.map { shop in
            HomeGarageViewEntity.ListGarage1(storeId: shop.storeId, name: shop.name, address: shop.address, phone: shop.phone, status: shop.status, serviceList: shop.serviceList.map { service in
                HomeGarageViewEntity.ServiceListGaraHung(serviceId: service.serviceId, name: service.name, price: service.price, typeVehicle: service.typeVehicle)
                
            },
                                             comments: shop.comments.map { commentt in
                HomeGarageViewEntity.CommentsHung(numberStar: commentt.numberStar, content: commentt.content, createdTime: commentt.createdTime)
            })
         
        } ?? []
      
    }
}

final class HomeGarageModel {
    
}

extension HomeGarageModel: HomeGarageModelProtocol {
    func getListShop(address: String, result: @escaping (Result<HomeGarageViewEntity, String>) -> Void) {
        HomeAPI.share.getListShop(address: address) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(HomeGarageViewEntity(array: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
}
