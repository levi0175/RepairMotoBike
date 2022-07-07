//
//  EvaluateAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 26/05/2022.
//

import Foundation
import Alamofire

protocol EvaluateAPIProtocol {
    func postComment(idUser: Int, idStore: Int, star: Int, content: String, createdTime: String, result: @escaping (Result<EvaluateAPIReponse, ErrorAPI>) -> Void)
}

final class EvaluateAPI: BaseAPIFetcher {
    static let share = EvaluateAPI()

}

extension EvaluateAPI: EvaluateAPIProtocol {
    func postComment(idUser: Int, idStore: Int, star: Int, content: String, createdTime: String, result: @escaping (Result<EvaluateAPIReponse, ErrorAPI>) -> Void) {
        
        guard let url = apiURL("v1/users/\(idUser)/comments?storeId=\(idStore)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = EvaluateAPIRequest(star: star, content: content, createdTime: createdTime)
        request(url: url,
                httpMethod: .post,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
              //  print("data:", String(decoding: data, as: UTF8.self))
                guard let dataResponse = try? JSONDecoder().decode(EvaluateAPIReponse.self, from: data)
                else {
                    result(.failure(ErrorAPI(status: 7, message: ResponseError.unableToDecode.rawValue)))
                    return
                }
                result(.success(dataResponse))
            case .failure(let error):
                print(error)
                result(.failure(error))
            }
        }
    }
    
}
