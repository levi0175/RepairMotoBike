//  
//  CustomerLoyalModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

struct CustomerLoyalViewEntity {
    struct ListUserLoyal: Codable {
        let name: String
        let gender: String?
        let phone: String?
        let address: String?
        let age: Int?
        let status: Int?
        let billList: [BillListResponseShow]
    }
    struct BillListResponseShow: Codable {
        let userName: String?
        let phoneUser: String?
        let timeRepair: String?
        let numberPlate: String?
        let services: [HomeGarageViewEntity.ServiceListGaraHung]
        let created_time: String?
    }
    var listUser: [CustomerLoyalViewEntity.ListUserLoyal] = []
    init(array: [UserLoyalResponse]? = nil) {
        self.listUser = array?.map { userLoyal in
            CustomerLoyalViewEntity.ListUserLoyal(name: userLoyal.name, gender: userLoyal.gender, phone: userLoyal.phone, address: userLoyal.address, age: userLoyal.age, status: userLoyal.status, billList: userLoyal.billList.map { bill in
                CustomerLoyalViewEntity.BillListResponseShow(userName: bill.userName, phoneUser: bill.phoneUser, timeRepair: bill.timeRepair, numberPlate: bill.numberPlate, services: bill.serviceDTOList.map { ser in
                    HomeGarageViewEntity.ServiceListGaraHung(serviceId: ser.serviceId, name: ser.name, price: ser.price, typeVehicle: ser.typeVehicle)
                }, created_time: bill.created_time)
            })
            
        } ?? []
    }
}

final class CustomerLoyalModel {
    
}

extension CustomerLoyalModel: CustomerLoyalModelProtocol {
    func getListUserLoyal(result: @escaping (Result<CustomerLoyalViewEntity, String>) -> Void) {
        UserLoyalAPI.share.getListUserLoyal { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(CustomerLoyalViewEntity(array: data.data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
}
