//  
//  EvaluateModel.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 10/05/2022.
//

import Foundation

struct EvaluateViewEntity {
 
    var data: EvaluateAPIReponse?
    
//    init(array: EvaluateAPIReponse? = nil) {
//        commentData = array?.map { serviceId in
//            EvaluateViewEntity.Comment(code: serviceId.code, success: serviceId.success, description: serviceId.description, data: serviceId.data)
//        } ?? []
//    }
}

final class EvaluateModel {
    
}

extension EvaluateModel: EvaluateModelProtocol {
    func postComment(idUser: Int, idStore: Int, star: Int, content: String, createdTime: String, result: @escaping (Result<EvaluateViewEntity, String>) -> Void) {
        EvaluateAPI.share.postComment(idUser: idUser, idStore: idStore, star: star, content: content, createdTime: createdTime) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(EvaluateViewEntity(data: data)))
            case .failure(let error):
                result(.failure(error.message))
            }
        }
    }
}
