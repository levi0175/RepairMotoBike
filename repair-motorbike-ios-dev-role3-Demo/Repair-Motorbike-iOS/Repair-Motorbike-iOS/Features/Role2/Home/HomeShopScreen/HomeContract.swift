//  
//  HomeShopContract.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

protocol HomeContract {
    typealias Model = HomeModelProtocol
    typealias Controller = HomeControllerProtocol
    typealias View = HomeViewProtocol
}

protocol HomeModelProtocol {
    func getListShop(result: @escaping (Result<HomeViewEntity, String>) -> Void)
}

protocol HomeControllerProtocol: BaseViewControllerProtocol {
    func set(model: HomeContract.Model)
}

protocol HomeViewProtocol {
}
