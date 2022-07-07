//
//  Role1ListBooking.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 02/06/2022.
//

import Foundation

struct ListBookingResponse: Decodable, Encodable {
       let bookingId: Int
       let userName: String?
       let phoneUser: String?
       let storeName: String?
       let timeRepair: String?
       let numberPlate: String?
       let serviceDTOList: [DetailGarageAPIResponse]
       let created_time: String?
    
}
