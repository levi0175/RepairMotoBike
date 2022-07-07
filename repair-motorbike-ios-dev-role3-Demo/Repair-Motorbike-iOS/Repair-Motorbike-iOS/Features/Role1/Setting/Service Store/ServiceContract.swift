//  
//  ServiceContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 19/05/2022.
//

import Foundation

protocol ServiceContract {
    typealias Model = ServiceModelProtocol
    typealias Controller = ServiceControllerProtocol
    typealias View = ServiceViewProtocol
}

protocol ServiceModelProtocol {
    
}

protocol ServiceControllerProtocol: BaseViewControllerProtocol {
    func set(model: ServiceContract.Model)
}

protocol ServiceViewProtocol {
}
