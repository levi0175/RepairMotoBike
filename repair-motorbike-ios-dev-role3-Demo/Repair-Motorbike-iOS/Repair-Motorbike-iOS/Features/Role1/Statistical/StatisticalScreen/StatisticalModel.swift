//
//  StatisticalModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

struct StatisticalViewEntity {
    struct Chart {
        let totalCustomer: Int
        let totalPrice: Double
        let timeRepair: String
        
        init(totalCustomer: Int, totalPrice: Double, timeRepair: String) {
            self.totalCustomer = totalCustomer
            self.totalPrice = totalPrice
            self.timeRepair = timeRepair
        }
    }
    var listChart: [Chart] = []
    init(array: [ChartAPIResponse]? = nil ) {
        listChart = array?.map { storeId in StatisticalViewEntity.Chart(totalCustomer: storeId.totalCustomer, totalPrice: storeId.totalPrice, timeRepair: storeId.timeRepair)
        } ?? []
    }
}

final class StatisticalModel {
    
}

extension StatisticalModel: StatisticalModelProtocol {
    func getListChartDay(storeId: Int, result: @escaping (Result<StatisticalViewEntity, String>) -> Void) {
        ChartAPI.share.geiChartAPIServiceDay(storeId: storeId, result: { dataResult in
            switch dataResult {
            case .success(let data):
                    result(.success(StatisticalViewEntity(array: data.data)))
            case .failure(let error):
                    result(.failure(error.message))
                }
        })
    }
}
