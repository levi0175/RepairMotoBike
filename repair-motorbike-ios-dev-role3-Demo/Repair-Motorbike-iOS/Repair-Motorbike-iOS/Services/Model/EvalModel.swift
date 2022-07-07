//
//  EvaluateModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 26/05/2022.
//

import Foundation

// MARK: MODEL REQUEST
struct EvaluateAPIRequest: Codable {
    let star: Int
    let content: String?
    let createdTime: String?
}
// MARK: MODEL RESPONSE
// Created
struct EvaluateAPIReponse: Codable {
    let code: String
    let success: Bool
    let description: String
    let data: String
}
