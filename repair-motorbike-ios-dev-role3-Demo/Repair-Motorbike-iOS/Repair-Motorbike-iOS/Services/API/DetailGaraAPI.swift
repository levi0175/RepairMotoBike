//
//  ServicesShopAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 06/05/2022.
//

import Foundation
import Alamofire

protocol DetailGaraAPIProtocal {
    func getListStoreService(storeId: Int, result: @escaping (Result<BaseAPI<[DetailGarageAPIResponse]>, ErrorAPI>) -> Void)
    func getListComment(storeId: Int, result: @escaping (Result<BaseAPI<[DetailReponseComment]>, ErrorAPI>) -> Void)
}

final class DetailGaraAPI: BaseAPIFetcher {
    static let share = DetailGaraAPI()
}

extension DetailGaraAPI: DetailGaraAPIProtocal {
    func getListComment(storeId: Int, result: @escaping (Result<BaseAPI<[DetailReponseComment]>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Shop.comment + "\(storeId)" + ServerConstant.APIPath.Shop.listComment)
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                print("data:", String(decoding: data, as: UTF8.self))
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[DetailReponseComment]>.self, from: data)
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
    
    func getListStoreService(storeId: Int, result: @escaping (Result<BaseAPI<[DetailGarageAPIResponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Shop.service + "\(storeId)")
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                //https://71d66a89-5dba-4500-a582-ad12e926c2b1.mock.pstmn.io
        //https://a64aba31-9b0c-4fe4-a643-3fb04d0e3fd9.mock.pstmn.io/repairShop
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[DetailGarageAPIResponse]>.self, from: data)
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
