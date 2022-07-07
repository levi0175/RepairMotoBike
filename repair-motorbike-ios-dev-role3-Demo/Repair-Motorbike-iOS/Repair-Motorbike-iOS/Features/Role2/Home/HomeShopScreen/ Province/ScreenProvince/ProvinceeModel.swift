//  
//  ProvinceeModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 26/05/2022.
//

import Foundation

struct ProvinceeViewEntity {
    struct ListProvince {
        let list: ProvinceAPIReponse
    }
    var listAllShop: [ListProvince] = []
    
    init(array: [ProvinceAPIReponse]? = nil) {
        listAllShop = array?.map { shop in
            ProvinceeViewEntity.ListProvince(list: ProvinceAPIReponse(name: shop.name))
        } ?? []
    }
}
final class ProvinceeModel {
    
}

extension ProvinceeModel: ProvinceeModelProtocol {
    func getListProvince(result: @escaping (Result<ProvinceeViewEntity, String>) -> Void) {
        ProvinceAPI.share.getListProvince { dataResult in
                switch dataResult {
                case .success(let data):
                    result(.success(ProvinceeViewEntity(array: data.data)))
                case .failure(let error):
                    result(.failure(error.message))
                }
            }
    }
}
