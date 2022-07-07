//
//  UserLoyalAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 05/06/2022.
//

import Foundation
protocol UserLoyalAPIProtocal {
    func getListUserLoyal(result: @escaping (Result<BaseAPI<[UserLoyalResponse]>, ErrorAPI>) -> Void)
}
final class UserLoyalAPI: BaseAPIFetcher {
    static let share = UserLoyalAPI()
    
}
extension UserLoyalAPI: UserLoyalAPIProtocal {
    func getListUserLoyal(result: @escaping (Result<BaseAPI<[UserLoyalResponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL("v1/stores/1/users-loyal")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[UserLoyalResponse]>.self, from: data)
                else {
                    result(.failure(ErrorAPI(status: 7, message: ResponseError.unableToDecode.rawValue)))
                    return
                }
                result(.success(dataResponse))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }
    
}
