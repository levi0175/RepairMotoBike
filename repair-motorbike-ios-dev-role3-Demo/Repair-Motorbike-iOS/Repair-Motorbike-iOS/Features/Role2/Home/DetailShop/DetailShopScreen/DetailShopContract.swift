//  
//  DetailShopContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 29/04/2022.
//

import Foundation

protocol DetailShopContract {
    typealias Model = DetailShopModelProtocol
    typealias Controller = DetailShopControllerProtocol
    typealias View = DetailShopViewProtocol
}

protocol DetailShopModelProtocol {
    func getListStoreService(storeId: Int, result: @escaping (Result<DetailShopViewEntity, String>) -> Void)
    func getlistComment(storeId: Int, result: @escaping (Result<DetailShopViewEntity, String>) -> Void)
}

protocol DetailShopControllerProtocol: BaseViewControllerProtocol {
    func set(model: DetailShopContract.Model)
}

protocol DetailShopViewProtocol {
}
