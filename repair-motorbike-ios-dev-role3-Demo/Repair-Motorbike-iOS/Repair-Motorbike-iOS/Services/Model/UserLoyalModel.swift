//
//  UserLoyalModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 05/06/2022.
//

import Foundation
struct UserLoyalResponse: Decodable, Encodable {
       let name: String
       let gender: String?
       let phone: String?
       let address: String?
       let age: Int?
       let status: Int?
       let billList: [BillListResponse]
    
}
struct BillListResponse: Decodable, Encodable {
    let userName: String?
    let phoneUser: String?
    let timeRepair: String?
    let numberPlate: String?
    let serviceDTOList: [DetailGarageAPIResponse]
    let created_time: String?
}
