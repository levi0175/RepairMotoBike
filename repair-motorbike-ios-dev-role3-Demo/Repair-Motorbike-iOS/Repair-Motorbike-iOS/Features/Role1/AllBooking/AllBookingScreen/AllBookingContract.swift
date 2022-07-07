//  
//  AllBookingContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 12/05/2022.
//

import Foundation

protocol AllBookingContract {
    typealias Model = AllBookingModelProtocol
    typealias Controller = AllBookingControllerProtocol
    typealias View = AllBookingViewProtocol
}

protocol AllBookingModelProtocol {
    func getListBook(idStore: Int, startDate: String, endDate: String, result: @escaping (Result<AllBookingViewEntity, String>) -> Void)
    func getListBookAll(idStore: Int, result: @escaping (Result<AllBookingViewEntity, String>) -> Void)
    func confirmBooking(idStore: Int, booking: Int, result: @escaping (Result<AllBookingViewEntity, String>) -> Void)
    func deleteBooking(idBooking: Int, result: @escaping (Result<AllBookingViewEntity, String>) -> Void)
}

protocol AllBookingControllerProtocol: BaseViewControllerProtocol {
    func set(model: AllBookingContract.Model)
}

protocol AllBookingViewProtocol {
}
