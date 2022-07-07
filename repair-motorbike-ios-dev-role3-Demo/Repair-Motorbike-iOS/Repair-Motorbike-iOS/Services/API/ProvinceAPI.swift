//
//  ProvinceAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 26/05/2022.
//

import Foundation
protocol ProvinceAPIProtocal {
    func getListProvince(result: @escaping (Result<BaseAPI<[ProvinceAPIReponse]>, ErrorAPI>) -> Void)
}

final class ProvinceAPI: BaseAPIFetcher {
    static let share = ProvinceAPI()
}

extension ProvinceAPI: ProvinceAPIProtocal {
    func getListProvince(result: @escaping (Result<BaseAPI<[ProvinceAPIReponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Shop.province)
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[ProvinceAPIReponse]>.self, from: data)
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
