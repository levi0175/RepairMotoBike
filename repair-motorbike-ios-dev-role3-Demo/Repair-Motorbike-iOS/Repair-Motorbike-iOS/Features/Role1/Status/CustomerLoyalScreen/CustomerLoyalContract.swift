//  
//  CustomerLoyalContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

protocol CustomerLoyalContract {
    typealias Model = CustomerLoyalModelProtocol
    typealias Controller = CustomerLoyalControllerProtocol
    typealias View = CustomerLoyalViewProtocol
}

protocol CustomerLoyalModelProtocol {
    func getListUserLoyal(result: @escaping (Result<CustomerLoyalViewEntity, String>) -> Void)
}

protocol CustomerLoyalControllerProtocol: BaseViewControllerProtocol {
    func set(model: CustomerLoyalContract.Model)
}

protocol CustomerLoyalViewProtocol {
}
