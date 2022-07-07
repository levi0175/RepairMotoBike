//
//  KeychainWrapperError.swift
//  Repair-Motorbike-iOS
//
//  Created by NguyenVietAnh on 21/04/2022.
//

import Foundation

public enum KeychainWrapperError: Error {
    case string2DataConversionError
    case data2StringConversionError
    case unhandledError(message: String)
}

extension KeychainWrapperError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .string2DataConversionError:
            return NSLocalizedString("String to Data conversion error", comment: "")
        case .data2StringConversionError:
            return NSLocalizedString("Data to String conversion error", comment: "")
        case .unhandledError(let message):
            return NSLocalizedString(message, comment: "")
        }
    }
}
