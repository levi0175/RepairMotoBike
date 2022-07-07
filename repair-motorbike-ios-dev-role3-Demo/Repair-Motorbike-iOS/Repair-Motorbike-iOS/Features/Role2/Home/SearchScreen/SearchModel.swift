//  
//  SearchModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 09/05/2022.
//

import Foundation

struct SearchViewEntity {
    struct ListShopSearch {
        let search: HomeGarageViewEntity.ListGarage1
    }
    var listAllShop: [ListShopSearch] = []
    init(array: [ShopAPIResponse1]? = nil) {
        listAllShop = array?.map { shop in
            SearchViewEntity.ListShopSearch(search: HomeGarageViewEntity.ListGarage1(storeId: shop.storeId, name: shop.name, address: shop.address, phone: shop.phone, status: shop.status, serviceList: shop.serviceList.map { servicer in
                HomeGarageViewEntity.ServiceListGaraHung(serviceId: servicer.serviceId, name: servicer.name, price: servicer.price, typeVehicle: servicer.typeVehicle)
            }, comments: shop.comments.map { commentt in
                HomeGarageViewEntity.CommentsHung(numberStar: commentt.numberStar, content: commentt.content, createdTime: commentt.createdTime)
            }))
        } ?? []
//            SearchViewEntity.ListShopSearch(storeId: shop.storeId, name: shop.name, address: shop.address, phone: shop.phone, status: shop.status, serviceList: shop.serviceList.map { service in
//                HomeGarageViewEntity.ServiceListGaraHung(serviceId: service.serviceId, name: service.name, price: service.price, typeVehicle: service.typeVehicle)
//
//            },
//                                             comments: shop.comments.map { commentt in
//                HomeGarageViewEntity.CommentsHung(numberStar: commentt.numberStar, content: commentt.content, createdTime: commentt.createdTime)
//            })
//
//        } ?? []
    }
}

final class SearchModel {
    
}

extension SearchModel: SearchModelProtocol {
    func getListSearch(result: @escaping (Result<SearchViewEntity, String>) -> Void) {
        SearchAPI.share.getListSearch { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(SearchViewEntity(array: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    
}
