//
//  DetailGarageAPIModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 06/05/2022.
//

import Foundation

// MARK: MODEL REQUEST
struct DetailGarageAPIRequest: Codable {
    let storeId: Int
}
// MARK: MODEL RESPONSE
struct DetailGarageAPIResponse: Codable {
    let serviceId: Int?
    let name: String?
    let price: Double?
    let typeVehicle: String?
}
struct DetailReponseComment: Codable {
    let userName: String
    let numberStar: Int?
    let content: String?
    let createdTime: String?
}
