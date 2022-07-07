//
//  DetailShopModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 29/04/2022.
//

import Foundation

struct DetailShopViewEntity {
    struct ListComment {
        let userName: String
        let numberStar: Int
        let content: String
        let createdTime: String
    
        init(userName: String, numberStar: Int?, content: String?, createdTime: String?) {
            self.userName = userName
            self.numberStar = numberStar ?? 5
            self.content = content ?? ""
            self.createdTime = createdTime ?? "\(Date())"
        }
    }
    struct ListShop {
        let serviceId: Int
        let name: String
        let price: Double
        let typeVehicle: String
    
        init(serviceId: Int?, name: String?, price: Double?, typeVehicle: String?) {
            self.serviceId = serviceId ?? 1
            self.name = name ?? ""
            self.price = price ?? 0.0
            self.typeVehicle = typeVehicle ?? ""
        }
    }
    var listCommentList: [ListComment] = []
    var listAllStoreService: [ListShop] = []
    
    init(array: [DetailGarageAPIResponse]? = nil) {
        listAllStoreService = array?.map { serviceId in
            DetailShopViewEntity.ListShop(serviceId: serviceId.serviceId, name: serviceId.name, price: serviceId.price, typeVehicle: serviceId.typeVehicle)
        } ?? []
    }
    
    init(array123: [DetailReponseComment]? = nil) {
        listCommentList = array123?.map { serviceId in
            DetailShopViewEntity.ListComment(userName: serviceId.userName, numberStar: serviceId.numberStar, content: serviceId.content, createdTime: serviceId.createdTime)
        } ?? []
    }
}
extension HomeGarageViewEntity {
    
}

final class DetailShopModel {

}

extension DetailShopModel: DetailShopModelProtocol {
    func getlistComment(storeId: Int, result: @escaping (Result<DetailShopViewEntity, String>) -> Void) {
        DetailGaraAPI.share.getListComment(storeId: storeId, result: { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(DetailShopViewEntity(array123: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        })
//        DetailGaraAPI.share.getListComment(storeId: storeId, result: { dataResult in
//            switch dataResult {
//            case .success(let data):
//                result(.success(DetailShopViewEntity(array: data.data)))
//            case .failure(let error):
//                result(.failure(error.message))
//            }
//        })
    }
    
    func getListStoreService(storeId: Int, result: @escaping (Result<DetailShopViewEntity, String>) -> Void) {
        DetailGaraAPI.share.getListStoreService(storeId: storeId, result: { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(DetailShopViewEntity(array: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        })
    }
}
