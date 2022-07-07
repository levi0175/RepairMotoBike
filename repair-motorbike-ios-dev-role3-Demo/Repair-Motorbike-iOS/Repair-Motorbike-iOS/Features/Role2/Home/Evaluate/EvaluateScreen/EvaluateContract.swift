//  
//  EvaluateContract.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 10/05/2022.
//

import Foundation

protocol EvaluateContract {
    typealias Model = EvaluateModelProtocol
    typealias Controller = EvaluateControllerProtocol
    typealias View = EvaluateViewProtocol
}

protocol EvaluateModelProtocol {
    func postComment(idUser: Int, idStore: Int, star: Int, content: String, createdTime: String, result: @escaping (Result<EvaluateViewEntity, String>) -> Void)
}

protocol EvaluateControllerProtocol: BaseViewControllerProtocol {
    func set(model: EvaluateContract.Model)
}

protocol EvaluateViewProtocol {
}
