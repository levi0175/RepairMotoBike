//  
//  BookContract.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 26/04/2022.
//

import Foundation

protocol BookContract {
    typealias Model = BookModelProtocol
    typealias Controller = BookControllerProtocol
    typealias View = BookModelProtocol
}

protocol BookModelProtocol {
  //  func getListShop(result: @escaping (Result<BookViewEntity, String>) -> Void)
    func getUser(id: Int, result: @escaping (Result<BookViewEntity, String>) -> Void)
}

protocol BookControllerProtocol: BaseViewControllerProtocol {
    func set(model: BookContract.Model)
}
