//  
//  CalenderContract.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 27/04/2022.
//

import Foundation

protocol CalenderContract {
    typealias Model = CalenderModelProtocol
    typealias Controller = CalenderControllerProtocol
    typealias View = CalenderViewProtocol
}

protocol CalenderModelProtocol {
    
}

protocol CalenderControllerProtocol: BaseViewControllerProtocol {
    func set(model: CalenderContract.Model)
}

protocol CalenderViewProtocol {
}
