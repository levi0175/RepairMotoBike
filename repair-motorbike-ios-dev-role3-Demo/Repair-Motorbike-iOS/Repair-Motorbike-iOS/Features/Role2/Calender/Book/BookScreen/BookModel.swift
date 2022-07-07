//  
//  BookModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 26/04/2022.
//

import Foundation

struct BookViewEntity {
   
        var data: UserAPIResponse?
  
//    struct ListShopSearch {
//        let search: HomeGarageViewEntity.ListGarage1
//
//    }
//    var listAllShop: [ListShopSearch] = []
//
//    init(array: [ShopAPIResponse1]? = nil) {
//        listAllShop = array?.map { shop in
//            BookViewEntity.ListShopSearch(search: HomeGarageViewEntity.ListGarage1(storeId: shop.storeId, name: shop.name, address: shop.address, phone: shop.phone, status: shop.status, serviceList: [], comments: []))
//        } ?? []
//    }
}
final class BookModel {
    
}
extension BookModel: BookModelProtocol {
    func getUser(id: Int, result: @escaping (Result<BookViewEntity, String>) -> Void) {
        UserAPI.share.getDataUser(id: id) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(BookViewEntity(data: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    
//    func getListShop(result: @escaping (Result<BookViewEntity, String>) -> Void) {
//        HomeAPI.share.getListShop(address: "Ha noi") { dataResult in
//            switch dataResult {
//            case .success(let data):
//                result(.success(BookViewEntity(array: data.data)))
//            case .failure(let error):
//                result(.failure(error.message))
//            }
//        }
//    }
//    func getUser(id: Int, result: @escaping (Result<BookViewEntity, String>) -> Void) {
//        UserAPI.share.getDataUser(id: id) { dataResult in
//            switch dataResult {
//            case .success(let data):
//                    result(.success(BookViewEntity(array: data.data?)))
//            case .failure(let error):
//                result(.failure(error.message))
//            }
//        }
//    }
}
