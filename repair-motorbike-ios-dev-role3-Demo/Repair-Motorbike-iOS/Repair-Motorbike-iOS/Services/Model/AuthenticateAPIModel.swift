//
//  AuthenticateAPIModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

// MARK: MODEL REQUEST
struct LoginAPIRequest: Codable {
    let phone: String
    let password: String
}

struct RegisterAPIRequest: Codable {
    let phone: String
    let password: String
    let address: String
    let name: String
    let age: Int
    let gender: String
}

struct RefreshTokenAPIRequest: Codable {
    let refreshToken: String
}

// MARK: MODEL RESPONSE
struct AuthenticateAPIResponse: Codable {
    let id: Int
    let phone: String
    let roles: [String]
    let accessToken: String
    let tokenType: String

}
struct RegisterAPIResponse: Codable {
    let phone: Int
    let password: String
    let name: String
    let old: Int
    let sex: String
}
