//  
//  DetailBookContract.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 05/05/2022.
//

import Foundation

protocol DetailBookContract {
    typealias Model = DetailBookModelProtocol
    typealias Controller = DetailBookControllerProtocol
    typealias View = DetailBookViewProtocol
}

protocol DetailBookModelProtocol {
    func getListBooking(garaId: Int, userId: Int, userName: String, userPhone: String?, timeRepair: String, numberPlate: String?, services: [ListServiceAPIResponse], result: @escaping(Result<DetailBookViewEntity, String>) -> Void)

}

protocol DetailBookControllerProtocol: BaseViewControllerProtocol {
    func set(model: DetailBookContract.Model)
}

protocol DetailBookViewProtocol {
}
