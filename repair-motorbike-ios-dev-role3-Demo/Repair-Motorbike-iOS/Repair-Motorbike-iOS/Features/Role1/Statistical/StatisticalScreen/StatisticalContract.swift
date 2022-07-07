//  
//  StatisticalContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

protocol StatisticalContract {
    typealias Model = StatisticalModelProtocol
    typealias Controller = StatisticalControllerProtocol
    typealias View = StatisticalViewProtocol
}

protocol StatisticalModelProtocol {
    func getListChartDay(storeId: Int, result: @escaping (Result<StatisticalViewEntity, String>) -> Void)
}

protocol StatisticalControllerProtocol: BaseViewControllerProtocol {
    func set(model: StatisticalContract.Model)
}

protocol StatisticalViewProtocol {
}
