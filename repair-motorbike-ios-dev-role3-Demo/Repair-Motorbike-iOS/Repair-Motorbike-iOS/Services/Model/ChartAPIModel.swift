//
//  ChartAPIModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 02/06/2022.
//

import Foundation
struct ChartAPIRequest: Codable {
    let id: Int
}

struct ChartAPIResponse: Codable {
    let totalCustomer: Int
    let totalPrice: Double
    let timeRepair: String
}
