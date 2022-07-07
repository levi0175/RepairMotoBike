//
//  BaseAPIModel.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

// MARK: MODEL EMPTY
struct EmptyAPI: Codable {}

// MARK: BASE MODEL
struct BaseAPI<Model: Codable>: Codable {
    let code: String?
    let success: Bool?
    let description: String?
    let data: Model?
}
struct BaseResponseBoolAPI: Codable {
    let code: String
    let success: Bool
    let description: String
    let data: String
}
struct BaseAPIProVince<Model: Codable>: Codable {
    let success: Bool
    let description: String?
}
/// Model Error API
struct ErrorAPI: Error, Codable {
    /**
     Status Error.
     - Parameters:
        - 1: Lỗi truy vấn data trên server.
        - 2: Lỗi xuất phát do server.
        - 3: Lỗi thiếu params khi request API.
        - 4: Lỗi authorization.
        - 5: Lỗi Data nhận được khi request API.
        - 6: Lỗi failure nhận được khi request API.
        - 7: Lỗi xuất phát do app.
     */
    let status: Int
    /// Message Error.
    let message: String
}
