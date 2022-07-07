//  
//  HomeGarageContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 21/05/2022.
//

import Foundation

protocol HomeGarageContract {
    typealias Model = HomeGarageModelProtocol
    typealias Controller = HomeGarageControllerProtocol
    typealias View = HomeGarageViewProtocol
}

protocol HomeGarageModelProtocol {
    func getListShop(address: String, result: @escaping (Result<HomeGarageViewEntity, String>) -> Void)
}

protocol HomeGarageControllerProtocol: BaseViewControllerProtocol {
    func set(model: HomeGarageContract.Model)
}

protocol HomeGarageViewProtocol {
}
