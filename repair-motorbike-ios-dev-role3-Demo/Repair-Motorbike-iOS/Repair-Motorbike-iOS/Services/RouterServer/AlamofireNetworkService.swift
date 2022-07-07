//
//  AlamofireNetworkService.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation
import Alamofire

typealias AlamofireServerResult = (Result<Data, ErrorAPI>) -> Void

struct AlamofireNetworkService {
    private let sessionManager: Session
    // 71d66a89-5dba-4500-a582-ad12e926c2b1.mock.pstmn.io
    // 6271ddb8c455a64564b8bb2f.mockapi.io
   // e4f937c5-bed3-4354-9c41-3b8d491c754c.mock.pstmn.io
    // http://10.10.106.3:8081
    // http://192.168.137.1:8081/api/v1/users/searchStores-address

    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 90
        let serverTrust = ServerTrustManager(evaluators: [
            "10.10.104.214:8181": DisabledTrustEvaluator()
        ])
        sessionManager = Session(configuration: configuration, serverTrustManager: serverTrust)
    }

    private func convertHTTPMethod(_ method: HTTPMethod) -> Alamofire.HTTPMethod {
        var returnMethod: Alamofire.HTTPMethod
        switch method {
        case .get:
            returnMethod = Alamofire.HTTPMethod.get
        case .post:
            returnMethod = Alamofire.HTTPMethod.post
        case .put:
            returnMethod = Alamofire.HTTPMethod.put
        case .patch:
            returnMethod = Alamofire.HTTPMethod.patch
        case .delete:
            returnMethod = Alamofire.HTTPMethod.delete
        }
        return returnMethod
    }

    private func convertHTTPHeaders(_ headers: HTTPHeaders?) -> Alamofire.HTTPHeaders? {
        guard let headers: HTTPHeaders = headers
        else { return nil }
        return Alamofire.HTTPHeaders(headers)
    }

    /**
     Function kiểm tra response data và status code khi call API.
     [HTTP Status Code](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status)
     ```
     ErrorAPI(status: 5, message: "Message Error")
     ```
     - Parameters:
        - data: Response data nhận được khi gọi API.
        - httpStatusCode: Status code nhận được khi gọi API.
     - Returns: Nếu có lỗi trả về ErrorAPI, nếu không có lỗi trả về nil.
    */
    private func checkErrorServer(with data: Data?, httpStatusCode: Int?) -> ErrorAPI? {
        guard let data = data
        else { return ErrorAPI(status: 5, message: ResponseError.noData.rawValue) }

        switch httpStatusCode ?? 600 {
        case 200...299:
            return nil
        case 401:
             return decodeError(with: data, message: ResponseError.authenticationError.rawValue)
        default:
            return decodeError(with: data, message: ResponseError.badRequest.rawValue)
        }
    }

    /**
     Function giải mã dữ liệu Data sang ErrorAPI.
     ```
     ErrorAPI(status: 5, message: "Message Error")
     ```
     - Parameters:
        - data: Response data nhận được khi gọi API.
        - message: Message mặc định khi giải mã thất bại.
     - Returns: Trả về ErrorAPI.
    */
    private func decodeError(with data: Data, message: String? = nil) -> ErrorAPI {
        do {
            let dataError = try JSONDecoder().decode(ErrorAPI.self, from: data)
            return dataError
        } catch let error {
            return ErrorAPI(status: 5, message: message ?? error.localizedDescription)
        }
    }

    /**
     Function kiểm tra error khi call API thất bại.
     ```
     ErrorAPI(status: 5, message: "Message Error")
     ```
     - Parameters:
        - afError: AFError nhận được khi gọi API thất bại.
     - Returns: Trả về ErrorAPI.
    */
    private func checkErrorServer(with afError: AFError) -> ErrorAPI {
        Logger.debug(afError)
        switch afError {
        case .sessionTaskFailed(error: let error):
            switch error._code {
            case NSURLErrorTimedOut:
                return ErrorAPI(status: 6, message: ResponseError.sessionEnded.rawValue)
            case NSURLErrorNotConnectedToInternet:
                return ErrorAPI(status: 6, message: ResponseError.internet.rawValue)
            default:
                return ErrorAPI(status: 6, message: error.localizedDescription)
            }
        default:
            return ErrorAPI(status: 6, message: afError.localizedDescription)
        }
    }
}

extension AlamofireNetworkService {
    /**
     Function request API không có Body.
     ```
     result(.success(Data))
     result(.failure(ErrorAPI(status: 5, message: "Message Error")))
     ```
     - Parameters:
        - apiRequest: Thông tin request APIRequest.
        - result: Call back (Result<Data, ErrorAPI>) -> Void.
    */
    func request(from apiRequest: APIRequest, result: @escaping AlamofireServerResult) {
            let httpMethod: Alamofire.HTTPMethod = convertHTTPMethod(apiRequest.httpMethod)
            var header = ["Authorization": "Bearer \(AppPreferences.shared.getToken() ?? "")"]
            if let httpHeaders = apiRequest.httpHeaders {
                header = httpHeaders.merging(["Authorization": "Bearer \(AppPreferences.shared.getToken() ?? "")"]) { $1 }
            }
            let httpHeaders: Alamofire.HTTPHeaders? = convertHTTPHeaders(header)
            Logger.server(apiRequest)
            sessionManager.request(apiRequest.url,
                                   method: httpMethod,
                                   headers: httpHeaders) .response { response in
                switch response.result {
                case .success(let data):
                    if let error = self.checkErrorServer(with: data, httpStatusCode: response.response?.statusCode) {
                        result(.failure(error))
                    } else {
                        result(.success(data!))
                    }
                case .failure(let error):
                    result(.failure(self.checkErrorServer(with: error)))

                }
            }
        }

    /**
     Function request API có Body kiểu Json.
     ```
     result(.success(Data))
     result(.failure(ErrorAPI(status: 5, message: "Message Error")))
     ```
     - Parameters:
        - apiRequest: Thông tin request APIRequest.
        - bodyJson: Dữ liệu Body gửi lên khi request API.
        - result: Call back (Result<Data, ErrorAPI>) -> Void.
    */
    func request<T: Codable>(from apiRequest: APIRequest, bodyJson: T? = nil, result: @escaping AlamofireServerResult) {
            let httpMethod: Alamofire.HTTPMethod = convertHTTPMethod(apiRequest.httpMethod)
            var header = ["Authorization": "Bearer \(AppPreferences.shared.getToken() ?? "")"]
            if let httpHeaders = apiRequest.httpHeaders {
                header = httpHeaders.merging(["Authorization": "Bearer \(AppPreferences.shared.getToken() ?? "")"]) { $1 }
            }
            let httpHeaders: Alamofire.HTTPHeaders? = convertHTTPHeaders(header)
            sessionManager.request(apiRequest.url,
                                   method: httpMethod,
                                   parameters: bodyJson,
                                   encoder: JSONParameterEncoder.default,
                                   headers: httpHeaders) .response { response in
                switch response.result {
                case .success(let data):
                    if let error = self.checkErrorServer(with: data, httpStatusCode: response.response?.statusCode) {
                        result(.failure(error))
                    } else {
                        result(.success(data!))
                    }
                case .failure(let error):
                    result(.failure(self.checkErrorServer(with: error)))

                }
            }
        }
    /**
     Function request API có Body kiểu FormData.
     ```
     result(.success(Data))
     result(.failure(ErrorAPI(status: 5, message: "Message Error")))
     ```
     - Parameters:
        - apiRequest: Thông tin request APIRequest.
        - bodyFormData: Dữ liệu Body gửi lên khi request API.
        - files: Mảng chứa các file gửi lên khi request API.
        - result: Call back (Result<Data, ErrorAPI>) -> Void.
    */
    func request<T: Codable>(from apiRequest: APIRequest,
                             bodyFormData: T? = nil,
                             files: [File]? = nil,
                             result: @escaping AlamofireServerResult) {
        Logger.server(bodyFormData ?? "", files ?? "")
        AF.upload(multipartFormData: { multipartFormData in
            if let bodyFormData = bodyFormData {
                guard let dataEncode = try? JSONEncoder().encode(bodyFormData),
                      let dictionary = try? JSONSerialization.jsonObject(with: dataEncode, options: []) as? Parameters
                else {
                    result(.failure(ErrorAPI(status: 7, message: RequestError.encoding.rawValue)))
                    return
                }
                for (key, value) in dictionary {
                    multipartFormData.append("\(value ?? "")".data(using: .utf8)!, withName: key)
                }
            }
            if let files = files {
                for file in files {
                    multipartFormData.append(file.data,
                                             withName: file.key,
                                             fileName: file.fileName,
                                             mimeType: file.mimeType)
                }
            }
        }, to: apiRequest.url) .response { response in
            Logger.server(response)
            switch response.result {
            case .success(let data):
                if let error = self.checkErrorServer(with: data, httpStatusCode: response.response?.statusCode) {
                    result(.failure(error))
                } else {
                    result(.success(data!))
                }
            case .failure(let error):
                result(.failure(self.checkErrorServer(with: error)))
            }
        }
    }
}
