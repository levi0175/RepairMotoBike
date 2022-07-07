//
//  UserAPIModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

// MARK: MODEL REQUEST
struct UserAPIRequest: Codable {
    let id: Int
}

struct UpdateUserRequest: Codable {
    let name: String?
    let gender: String?
    let phone: String?
    let address: String?
    let age: Int?
}

struct ChangePassRequest: Codable {
    let passwordSaved: String?
    let newPassword: String?
}

struct RegisterStoreRequest: Codable {
    let name: String?
    let address: String?
    let phone: String?
    let services: [Services]?
}

struct Services: Codable {
    let name: String?
    let price: Int?
    let typeVehicle: String?
}

// MARK: MODEL RESPONSE
struct UserAPIResponse: Codable {
    let userId: Int
    let name: String?
    let gender: String?
    let phone: String?
    let address: String?
    let age: Int?
    let status: Int?
}

struct UpdateUserResponse: Codable {
    let code: String?
    let success: Bool?
    let description: String?
    let data: String?
}
