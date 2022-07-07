//
//  SearchAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 24/05/2022.
//

import Foundation
import Alamofire
protocol SearchAPIProtocal {
    func getListSearch(result: @escaping (Result<BaseAPI<[ShopAPIResponse1]>, ErrorAPI>) -> Void)
}

final class SearchAPI: BaseAPIFetcher {
    static let share = SearchAPI()
    
}

extension SearchAPI: SearchAPIProtocal {
    func getListSearch(result: @escaping (Result<BaseAPI<[ShopAPIResponse1]>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Shop.search)
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[ShopAPIResponse1]>.self, from: data)
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
    
