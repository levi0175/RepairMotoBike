//
//  EnumConstant.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

struct EnumConstant {
    enum Language: String, CaseIterable {
        case vietnamese = "vi"
        case english = "en"

        var title: String {
            switch self {
            case .vietnamese:
                return Localization.Language.Vietnamese
            case .english:
                return Localization.Language.English
            }
        }
    }
    
    enum BorderSide {
        case top, bottom, left, right
    }
}
