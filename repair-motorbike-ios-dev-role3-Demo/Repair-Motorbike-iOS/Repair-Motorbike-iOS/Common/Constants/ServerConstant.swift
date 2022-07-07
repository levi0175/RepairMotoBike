//
//  ServerConstant.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

struct ServerConstant {
    struct URLBase {
        static var product = "http://localhost:3000/api/"
        static var develop = "http://10.10.104.214:8181/api/"

        static var test = "http://localhost:3000/api/"
        
        static var mockAPIHome = "https://e4f937c5-bed3-4354-9c41-3b8d491c754c.mock.pstmn.io/"
        static var googleMaps = " comgooglemaps://?center="
        static var zoom = " &zoom="
        static var views = "&views="
        static var traffic = "traffic"
        static var  q = "&q="
    }

    struct APIPath {
        struct Authenticate {
            static let login = "auth/signin"
            static let register = "authenticate/register"
            static let refresh = "authenticatgie/refresh"
        }
        struct Shop {
            static let allShop = "garage/"
            static let service = "v1/stores/listSevrices/"
            static let comment = "v1/stores/"
            static let listComment = "/listComment"
            static let province = "v1/users/province"
            static let fillterProvince = "v1/users/searchStores-address"
            static let search = "v1/management/stores"
            
        }
        struct Chart {
            static let chart = "v1/stores/"
            static let chartDaly = "/statistics-daily"
        }

        struct User {
            static let list = "user/list"
            static let update = "user/"
            static let delete = "user/"
            static let user = "v1/users/"
        }
        struct Store {
            static let newStore = "v1/stores/newStore/"
            static let Store = "v1/stores/"
        }

        struct Image {
            static let avatar = "image/"
        }
    }
}
