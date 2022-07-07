//  
//  GetPassContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 28/04/2022.
//

import Foundation

protocol GetPassContract {
    typealias Model = GetPassModelProtocol
    typealias Controller = GetPassControllerProtocol
    typealias View = GetPassViewProtocol
}

protocol GetPassModelProtocol {
    
}

protocol GetPassControllerProtocol: BaseViewControllerProtocol {
    func set(model: GetPassContract.Model)
}

protocol GetPassViewProtocol {
}
