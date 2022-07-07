//
//  Localization.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

struct Localization {
    struct Language {
        static let Vietnamese = "Vietnamese".localized()
        static let English = "English".localized()
    }

    struct Common {
        static let Phone = "Phone".localized()
        static let Password = "Password".localized()
        static let Name = "Name".localized()
        static let Gender = "Gender".localized()
        static let Address = "Address".localized()

        static let Cancel = "Cancel".localized()
        static let OK = "OK".localized()
    }

    struct Authenticate {
        static let Login = "Login".localized()
        static let Register = "Register".localized()
    }

    struct Home {
        static let Home = "Home".localized()
        static let Avatar = "Avatar".localized()
    }

    struct Setting {
        static let Setting = "Setting".localized()
        static let Logout = "Logout".localized()
    }
}
