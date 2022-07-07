//  
//  ScheduleContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 07/05/2022.
//

import Foundation

protocol ScheduleContract {
    typealias Model = ScheduleModelProtocol
    typealias Controller = ScheduleControllerProtocol
    typealias View = ScheduleViewProtocol
}

protocol ScheduleModelProtocol {
    func getListBooked(userId: Int, result: @escaping (Result<ScheduleViewEntity, String>) -> Void)
    func getListBookedSuccess(userId: Int, result: @escaping (Result<ScheduleViewEntity, String>) -> Void)
}

protocol ScheduleControllerProtocol: BaseViewControllerProtocol {
    func set(model: ScheduleContract.Model)
}

protocol ScheduleViewProtocol {
}
