//
//  BookedAPIModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 27/05/2022.
//

import Foundation

// MARK: MODEL RESPONSE
struct BookedReponse: Codable {
    let bookingId: Int
    let userName: String?
    let phoneUser: String?
    let storeName: String?
    let timeRepair: String?
    let numberPlate: String?
    let serviceDTOList: [DetailGarageAPIResponse]
    let created_time: String?
}
struct BookedSuccessReponse: Codable {
    let userName: String
    let phoneUser: String?
    let storeName: String?
    let timeRepair: String?
    let numberPlate: String?
    let serviceDTOList: [DetailGarageAPIResponse]
    let created_time: String?
    
}
