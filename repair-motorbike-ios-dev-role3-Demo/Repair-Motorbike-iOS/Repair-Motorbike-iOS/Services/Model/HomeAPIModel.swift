//
//  HomeAPIModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 29/04/2022.
//

import Foundation

// MARK: MODEL REQUEST
struct HomeAPIRequest: Codable {
    let address: String?
}
// MARK: MODEL RESPONSE
struct ShopAPIResponse: Codable {
    let storeID: String
    let nameShop: String?
    let address: String?
    let avatar: String?
    let vote: Int?
    let depcription: String?
    let locationX: String?
    let locationY: String?
}
struct ShopAPIResponse1: Encodable, Decodable {
    let storeId: Int
    let name: String?
    let address: String?
    let phone: String?
    let status: Int?
    let serviceList: [ServiceListGara]
    let comments: [Comments]
}
struct Comments: Encodable, Decodable {
    let numberStar: Int
    let content: String?
    let createdTime: String?
}
struct ServiceListGara: Encodable, Decodable {
    let serviceId: Int
    let name: String?
    let price: Double?
    let typeVehicle: String?
}
