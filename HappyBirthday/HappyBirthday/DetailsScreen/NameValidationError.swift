//
//  NameValidationError.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import Foundation

enum NameValidationError: LocalizedError {
    case empty
    case invalidCharacters
    case tooShort
    case notEnoughParts

    var errorDescription: String? {
        switch self {
        case .empty:
            return "name_error_empty".localized
        case .invalidCharacters:
            return "name_error_invalid_chars".localized
        case .tooShort:
            return "name_error_too_short".localized
        case .notEnoughParts:
            return "name_error_parts".localized
        }
    }
}

