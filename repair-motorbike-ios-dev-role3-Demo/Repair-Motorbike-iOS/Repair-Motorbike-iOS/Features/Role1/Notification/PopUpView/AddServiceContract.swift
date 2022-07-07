//  
//  AddServiceContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 07/06/2022.
//

import Foundation

protocol AddServiceContract {
    typealias Model = AddServiceModelProtocol
    typealias Controller = AddServiceControllerProtocol
    typealias View = AddServiceViewProtocol
}

protocol AddServiceModelProtocol {
    func postService(userId: Int, name: String, price: Double, typeVehicle: String, result: @escaping (Result<AddServiceViewEntity, String>) -> Void)
    func updateService(userId: Int, serviceId: Int, name: String, price: Double, typeVehicle: String, result: @escaping (Result<AddServiceViewEntity, String>) -> Void)
}

protocol AddServiceControllerProtocol: BaseViewControllerProtocol {
    func set(model: AddServiceContract.Model)
}

protocol AddServiceViewProtocol {
}
