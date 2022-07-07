//  
//  AddServiceModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 07/06/2022.
//

import Foundation

struct AddServiceViewEntity {
    var data: EvaluateAPIReponse?
}

final class AddServiceModel {
    
}

extension AddServiceModel: AddServiceModelProtocol {
    func postService(userId: Int, name: String, price: Double, typeVehicle: String, result: @escaping (Result<AddServiceViewEntity, String>) -> Void) {
        Role1ServiceAPI.share.postService(userId: userId, name: name, price: price, typeVehicle: typeVehicle) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(AddServiceViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
    func updateService(userId: Int, serviceId: Int, name: String, price: Double, typeVehicle: String, result: @escaping (Result<AddServiceViewEntity, String>) -> Void) {
        Role1ServiceAPI.share.updateService(userId: userId, serviceId: serviceId, name: name, price: price, typeVehicle: typeVehicle ) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(AddServiceViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
}
