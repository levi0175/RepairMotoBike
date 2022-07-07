//  
//  SearchContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 09/05/2022.
//
import Foundation

protocol SearchContract {
    typealias Model = SearchModelProtocol
    typealias Controller = SearchControllerProtocol
    typealias View = SearchViewProtocol
}

protocol SearchModelProtocol {
    func getListSearch(result: @escaping (Result<SearchViewEntity, String>) -> Void)
}

protocol SearchControllerProtocol: BaseViewControllerProtocol {
    func set(model: SearchContract.Model)
}

protocol SearchViewProtocol {
}
