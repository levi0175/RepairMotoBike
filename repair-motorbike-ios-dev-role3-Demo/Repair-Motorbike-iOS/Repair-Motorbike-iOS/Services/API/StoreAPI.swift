//
//  StoreAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Le Minh Hai on 04/06/2022.
//

import Foundation
import Alamofire

protocol StoreAPIProtocal {
    func getDataStore(id: Int, result: @escaping (Result<BaseAPI<StoreAPIResponse>, ErrorAPI>) -> Void)
}

final class StoreAPI: BaseAPIFetcher {
    static let share = StoreAPI()
}

extension StoreAPI: StoreAPIProtocal {
    func getDataStore(id: Int, result: @escaping (Result<BaseAPI<StoreAPIResponse>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Store.Store + "\(id)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<StoreAPIResponse>.self, from: data)
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
