//
//  HomeAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by Apple on 29/04/2022.
//

import Foundation
import Alamofire

protocol HomeAPIProtocal {
   // func getListShop(result: @escaping (Result<BaseAPI<[ShopAPIResponse1]>, ErrorAPI>) -> Void)
    func getListShop(address: String, result: @escaping (Result<BaseAPI<[ShopAPIResponse1]>, ErrorAPI>) -> Void)
}

final class HomeAPI: BaseAPIFetcher {
    static let share = HomeAPI()

}

extension HomeAPI: HomeAPIProtocal {
    func getListShop(address: String, result: @escaping (Result<BaseAPI<[ShopAPIResponse1]>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Shop.fillterProvince)
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        let params = HomeAPIRequest(address: address)
        request(url: url,
                httpMethod: .post,
                httpBody: .json,
                bodyParameters: params) { dataResult in
            switch dataResult {
            case .success(let data):
                print("data:", String(decoding: data, as: UTF8.self))
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[ShopAPIResponse1]>.self, from: data)
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
  
//    func getListShop(result: @escaping (Result<BaseAPI<[HomeAPIRequest]>, ErrorAPI>) -> Void) {
//       // guard let url = apiURLHome(ServerConstant.APIPath.Shop.allShop)
//        guard let url = URL.init(string: "http://192.168.137.1:8081/api/v1/users/searchStores-address")
//        else {
//            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
//            return
//        }
//        request(url: url,
//                httpMethod: .post
//        ) { dataResult in
//               // ) { dataResult in
//            switch dataResult {
//            case .success(let data):
//           // https://71d66a89-5dba-4500-a582-ad12e926c2b1.mock.pstmn.io
//                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[ShopAPIResponse1]>.self, from: data)
//                else {
//                    result(.failure(ErrorAPI(status: 7, message: ResponseError.unableToDecode.rawValue)))
//                    return
//                }
//                result(.success(dataResponse))
//            case .failure(let error):
//                result(.failure(error))
//            }
//        }
//    }
// }
