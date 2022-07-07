//
//  BaseAPIFetcher.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

enum RequestError: String {
    case url = "Request URL nil"
    case encoding = "Request Encoding Failed"
    case bodyParameters = "Body Parameters nil"
}

enum ResponseError: String {
    case authenticationError = "You need to be authenticated first."
    case sessionEnded = "Your session has ended."
    case internet = "Network request failed."
    case unableToDecode = "We could not decode the response."
    case outdated = "The url your requested is outdated."
    case noData = "Response returned with no data to decode."
    case badRequest = "Bad request."
    case other = "An error has occurred, please call 1900 58 58 85 for assistance."
}
enum GoogleMapsError: String {
    case googlemaps = "There's no direction available for this garage"
}

enum Result<Data, Error> {
    case success(_ data: Data)
    case failure(_ error: Error)
}

typealias RequestServerResult = (Result<Data, ErrorAPI>) -> Void

class BaseAPIFetcher {
    private let routerServer: AlamofireNetworkService

    init(routerServer: AlamofireNetworkService = AlamofireNetworkService()) {
        self.routerServer = routerServer
    }

    /**
     Function nối url với queryParameters.
     - Parameters:
        - url: URL request API.
        - parameters: Dữ liệu nối vào url.
     - Returns: URL?.
    */
    private func apiURLAndQuery<T: Codable>(_ url: URL, parameters: T) -> URL? {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = [URLQueryItem]()

        guard let jsonData = try? JSONEncoder().encode(parameters),
              let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? Parameters
        else { return nil }

        for (key, value) in dictionary where value != nil {
            let queryItem = URLQueryItem(name: key, value: "\(value ?? "")")
            urlComponents?.queryItems?.append(queryItem)
        }
        return urlComponents?.url
    }
}

extension BaseAPIFetcher {
    /**
     Function tạo url request.
     - Parameters:
        - path: path được nối vào URLBase.
     - Returns: URL?.
    */
    func apiURLHome(_ path: String = "") -> URL? {
        guard let url = URL(string: "\(ServerConstant.URLBase.mockAPIHome)\(path)")
        else { return nil }
        return url
    }
    func apiURL(_ path: String = "") -> URL? {
        guard let url = URL(string: "\(ServerConstant.URLBase.develop)\(path)")
        else { return nil }
        return url
    }
    func apiGoogleMaps(lat: Double, long: Double) -> URL? {
        guard let url = URL(string: "\(NameConstant.GoogleMaps.stringURL)?center=\(lat),\(long)&q=\(lat),\(long)&zoom=\(NameConstant.GoogleMaps.zoom)&views=\(NameConstant.GoogleMaps.trafficMode)") else {
            return nil
        }
        return  url
    }
    func apiComGoogle(lat: Double, long: Double) -> URL? {
        guard let url = URL(string: "https://www.google.co.in/maps/dir/?saddr=&daddr=\(lat),\(long)&directionsmode=driving") else {
            return nil
        }
        return  url
    }
    /**
     Function request API.
     - Parameters:
        - url: Địa trỉ request API.
        - httpMethod: Method "GET" "POST" "PUT" "PATCH" "DELETE"
        - httpHeaders: Headers bổ xung thêm [String: String]
        - result: Call back (Result<Data, ErrorAPI>) -> Void.
    */
    func request(url: URL,
                 httpMethod: HTTPMethod,
                 httpHeaders: HTTPHeaders? = nil,
                 result: @escaping RequestServerResult) {
        let apiRequest = APIRequest(url: url,
                                    httpMethod: httpMethod,
                                    httpHeaders: httpHeaders)
        routerServer.request(from: apiRequest) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(data))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }

    /**
     Function request API có queryParameters
     - Parameters:
        - url: Địa trỉ request API.
        - httpMethod: Method "GET" "POST" "PUT" "PATCH" "DELETE"
        - httpHeaders: Headers bổ xung thêm [String: String]
        - queryParameters: Dữ liệu Query nối vào url.
        - result: Call back (Result<Data, ErrorAPI>) -> Void.
    */
    func request<T: Codable>(url: URL,
                             httpMethod: HTTPMethod,
                             httpHeaders: HTTPHeaders? = nil,
                             queryParameters: T,
                             result: @escaping RequestServerResult) {
        guard let url = apiURLAndQuery(url, parameters: queryParameters)
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.encoding.rawValue)))
            return
        }
        let apiRequest = APIRequest(url: url,
                                    httpMethod: httpMethod,
                                    httpHeaders: httpHeaders)
        routerServer.request(from: apiRequest) { dataResult in
            switch dataResult {
            case .success(let data):
                result(.success(data))
            case .failure(let error):
                result(.failure(error))
            }
        }
    }

    /**
     Function request API có bodyParameters
     - Parameters:
        - url: Địa trỉ request API.
        - httpMethod: Method "GET" "POST" "PUT" "PATCH" "DELETE"
        - httpHeaders: Headers bổ xung thêm [String: String]
        - httpBody: Xác định kiểu dữ liệu Body là Json hay FormData
        - bodyParameters: Dữ liệu Body gửi lên khi request API.
        - files: Mảng chứa các file gửi lên khi request API.
        - result: Call back (Result<Data, ErrorAPI>) -> Void.
    */
    func request<T: Codable>(url: URL,
                             httpMethod: HTTPMethod,
                             httpHeaders: HTTPHeaders? = nil,
                             httpBody: HTTPBody,
                             bodyParameters: T? = nil,
                             files: [File]? = nil,
                             result: @escaping RequestServerResult) {
        let apiRequest = APIRequest(url: url,
                                    httpMethod: httpMethod,
                                    httpHeaders: httpHeaders)
        switch httpBody {
        case .json:
            routerServer.request(from: apiRequest,
                                 bodyJson: bodyParameters) { dataResult in
                switch dataResult {
                case .success(let data):
                    result(.success(data))
                case .failure(let error):
                    result(.failure(error))
                }
            }
        case .formData:
            routerServer.request(from: apiRequest,
                                 bodyFormData: bodyParameters,
                                 files: files) { dataResult in
                switch dataResult {
                case .success(let data):
                    result(.success(data))
                case .failure(let error):
                    result(.failure(error))
                }
            }
        }
    }

    /**
     Function request API có queryParameters và bodyParameters.
     - Parameters:
        - url: Địa trỉ request API.
        - httpMethod: Method "GET" "POST" "PUT" "PATCH" "DELETE"
        - httpHeaders: Headers bổ xung thêm [String: String]
        - httpBody: Xác định kiểu dữ liệu Body là Json hay FormData
        - queryParameters: Dữ liệu Query nối vào url.
        - bodyParameters: Dữ liệu Body gửi lên khi request API.
        - files: Mảng chứa các file gửi lên khi request API.
        - result: Call back (Result<Data, ErrorAPI>) -> Void.
    */
    func request<T: Codable, U: Codable>(url: URL,
                                         httpMethod: HTTPMethod,
                                         httpHeaders: HTTPHeaders? = nil,
                                         httpBody: HTTPBody,
                                         queryParameters: T,
                                         bodyParameters: U? = nil,
                                         files: [File]? = nil,
                                         result: @escaping RequestServerResult) {
        guard let url = apiURLAndQuery(url, parameters: queryParameters)
        else {
            result(.failure(ErrorAPI(status: 7, message: RequestError.encoding.rawValue)))
            return
        }
        let apiRequest = APIRequest(url: url,
                                    httpMethod: httpMethod,
                                    httpHeaders: httpHeaders)
        switch httpBody {
        case .json:
            routerServer.request(from: apiRequest,
                                 bodyJson: bodyParameters) { dataResult in
                switch dataResult {
                case .success(let data):
                    result(.success(data))
                case .failure(let error):
                    result(.failure(error))
                }
            }
        case .formData:
            routerServer.request(from: apiRequest,
                                 bodyFormData: bodyParameters,
                                 files: files) { dataResult in
                switch dataResult {
                case .success(let data):
                    result(.success(data))
                case .failure(let error):
                    result(.failure(error))
                }
            }
        }
    }
}
