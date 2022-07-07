//  
//  HomeModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

struct HomeViewEntity {
    struct ListShop {
        let storeID: String
        let nameShop: String
        let address: String
        let avatar: String
        let vote: Int
        let depcription: String
        let locationX: String
        let locationY: String

        init(storeID: String, nameShop: String?, address: String?, avatar: String?, vote: Int?, depcription: String?, locationX: String?, locationY: String? ) {
            self.storeID = storeID
            self.nameShop = nameShop ?? ""
            self.address = address ?? ""
            self.avatar = avatar ?? ""
            self.vote = vote ?? 0
            self.depcription = depcription ?? ""
            self.locationX = locationX ?? "0.0"
            self.locationY = locationY ?? "0.0"
        }
    }
    var listAllShop: [ListShop] = []

    init(array: [ShopAPIResponse]? = nil) {
        listAllShop = array?.map { shop in
            HomeViewEntity.ListShop(storeID: shop.storeID,
                                    nameShop: shop.nameShop,
                                    address: shop.address,
                                    avatar: shop.avatar,
                                    vote: shop.vote,
                                    depcription: shop.depcription,
                                    locationX: shop.locationX,
                                    locationY: shop.locationY)
        } ?? []
    }
}

final class HomeModel {
    
}
extension HomeModel: HomeModelProtocol {
    func getListShop(result: @escaping (Result<HomeViewEntity, String>) -> Void) {
        
    }
//    func getListShop(result: @escaping (Result<HomeViewEntity, String>) -> Void) {
//        HomeAPI.share.getListShop { dataResult in
//            switch dataResult {
//            case .success(let data):
//                result(.success(HomeViewEntity(array: data.data)))
//            case .failure(let error):
//                result(.failure(error.message))
//            }
//        }
//    }
}
