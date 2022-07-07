//  
//  NotificationContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

protocol NotificationContract {
    typealias Model = NotificationModelProtocol
    typealias Controller = NotificationControllerProtocol
    typealias View = NotificationViewProtocol
}

protocol NotificationModelProtocol {
    func getListService(userId: Int, result: @escaping (Result<NotificationViewEntity, String>) -> Void)
    func deleteService(idStore: Int, idService: Int, result: @escaping (Result<NotificationViewEntity, String>) -> Void)
}

protocol NotificationControllerProtocol: BaseViewControllerProtocol {
    func set(model: NotificationContract.Model)
}

protocol NotificationViewProtocol {
}
