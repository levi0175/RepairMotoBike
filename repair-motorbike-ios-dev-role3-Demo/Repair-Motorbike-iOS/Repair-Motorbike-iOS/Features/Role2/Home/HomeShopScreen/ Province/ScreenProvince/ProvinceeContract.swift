//  
//  ProvinceeContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 26/05/2022.
//

import Foundation

protocol ProvinceeContract {
    typealias Model = ProvinceeModelProtocol
    typealias Controller = ProvinceeControllerProtocol
    typealias View = ProvinceeViewProtocol
}

protocol ProvinceeModelProtocol {
    func getListProvince(result: @escaping (Result<ProvinceeViewEntity, String>) -> Void)
}

protocol ProvinceeControllerProtocol: BaseViewControllerProtocol {
    func set(model: ProvinceeContract.Model)
}

protocol ProvinceeViewProtocol {
}
