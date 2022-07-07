//
//  EndPointType.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

typealias HTTPHeaders = [String: String]
typealias Parameters = [String: Any?]

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum HTTPBody {
    case json
    case formData
}

struct APIRequest {
    var url: URL
    let httpMethod: HTTPMethod
    let httpHeaders: HTTPHeaders?

    init(url: URL, httpMethod: HTTPMethod, httpHeaders: HTTPHeaders? = nil) {
        self.url = url
        self.httpMethod = httpMethod
        self.httpHeaders = httpHeaders
    }
}

struct File {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
}
