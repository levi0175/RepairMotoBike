//
//  BookingModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 25/05/2022.
//

import Foundation

struct BookingAPIRequest: Codable {
    let userName: String?
    let userPhone: String?
    let timeRepair: String?
    let numberPlate: String?
    let services: [ListServiceAPIResponse?]
}
struct ListServiceAPIResponse: Codable {
    let serviceId: Int
}
struct BookingAPIResponse: Codable {
    let code: String
    let success: Bool
    let description: String?
    let data: String?
}
