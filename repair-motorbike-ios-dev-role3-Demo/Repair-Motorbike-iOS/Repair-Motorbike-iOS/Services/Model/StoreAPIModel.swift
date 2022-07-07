//
//  StoreAPIModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 04/06/2022.
//

import Foundation

struct StoreAPIResponse: Codable {
    let storeId: Int?
    let name: String?
    let address: String?
    let phone: String?
    let status: Int?
    let serviceList: [ServicesResponse]?
    let comments: [DetailReponseComment]?
}

struct ServicesResponse: Codable {
    let serviceId: Int?
    let name: String?
    let price: Float?
    let typeVehicle: String?
}

struct AddServicesRequest: Codable {
    let name: String?
    let price: Double?
    let typeVehicle: String?
}
