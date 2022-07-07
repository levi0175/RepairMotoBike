//
//  ChartAPI.swift
//  Repair-Motorbike-iOS
//
//  Created by NgocHap on 02/06/2022.
//

import Foundation

protocol ChartAPIProtocal {
    func geiChartAPIServiceDay(storeId: Int, result: @escaping (Result<BaseAPI<[ChartAPIResponse]>, ErrorAPI>) -> Void)
    
}
final class ChartAPI: BaseAPIFetcher {
    static let share = ChartAPI()
}
extension ChartAPI: ChartAPIProtocal {
    func geiChartAPIServiceDay(storeId: Int, result: @escaping (Result<BaseAPI<[ChartAPIResponse]>, ErrorAPI>) -> Void) {
        guard let url = apiURL(ServerConstant.APIPath.Chart.chart + "\(storeId)" + ServerConstant.APIPath.Chart.chartDaly) else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.url.rawValue)))
            return
        }
        request(url: url,
                httpMethod: .get) { dataResult in
            switch dataResult {
            case .success(let data):
                guard let dataResponse = try? JSONDecoder().decode(BaseAPI<[ChartAPIResponse]>.self, from: data)
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
