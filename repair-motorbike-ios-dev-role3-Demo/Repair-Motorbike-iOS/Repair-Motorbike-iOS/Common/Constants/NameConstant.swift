//
//  NameConstant.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

struct NameConstant {
    // MARK: - Storyboard Name
    struct Storyboard {
        static let Splash: String = "Splash"
        static let Authenticate: String = "Authenticate"
        static let Home: String = "Home"
        static let Calender: String = "Calender"
        static let Setting: String = "Setting"
        static let BookStep1: String = "BookStep1"
        static let BookStep2: String = "BookStep2"
        static let BookStep3: String = "BookStep3"
        static let DetailBook: String = "DetailBook"
        static let Detail: String = "DetailShop"
        static let Evaluate: String = "Evaluate"
        static let Schedule: String = "Schedule"
        static let Book: String = "Book"
        static let RegisterStore: String = "RegisterStore"
        static let AB: String = "AllBooking"
        static let Status: String = "Status"
        static let Notification: String = "Notification"
        static let Statistical: String = "Statistical"
        static let Role1Setting: String = "Role1Setting"
        static let CustomerLoyal: String = "CustomerLoyal"
        static let TrangChu: String = "Trang chủ"
        static let CaiDat: String = "Cài đặt"
        static let DatLich: String = "Đặt lịch"
        static let Evaldule: String = "Đánh giá cửa hàng"
        
    }
    struct ViewHome {
        static let schedule: String = "Đặt lịch"
        static let gift: String = "Khuyễn mãi"
        static let clean: String = "Rửa xe"
    }
    struct DetailGarage {
        static let long: String = "0.0"
        static let booking: String = "Đặt lịch ngay"
        static let map: String = "Phóng to"
        static let service: String = "Dịch vụ"
        static let infomation: String = "Thông tin"
        static let vote: String = "Đánh giá"

    }
    struct GoogleMaps {
        static let stringURL = "comgooglemaps://"
        static let zoom = 14
        static let trafficMode = "traffic"
        static let gooleMap = "Google Map"
    }
    struct Search {
        static let title = "Tìm kiếm"
        static let titlePro = "Tìm kiếm"
    }
    struct Schedule {
        static  let scheduled = "Đã đặt"
        static  let complete = "Hoàn thành"
        static  let canceled = "Đã huỷ"
        static  let lich = "Lịch hẹn"

    }
    struct UserDefaults {
        static let Language: String = "UserDefaults-Language"
        static let userID: String = "userID"
    }
    struct Size {
        static let Medium: String = "GillSans-Bold"
        static let Regular: String = "GillSans"
    }
    struct Font {
        
        static let Bold: String = "Baloo2-Medium"
        static let Regular: String = "Baloo2-Regular"
    }
    struct Keychain {
        static let Token: String = "KeyChain-Token"
    }
    struct Setting {
        static let nameSetting: [String] = ["Họ tên", "Số điện thoại", "Địa chỉ", "Thay đổi mật khẩu", "Liên hệ Repair Motobike"]
    }
   
}
