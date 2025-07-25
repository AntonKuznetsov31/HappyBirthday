//
//  DetailsViewModel.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import Foundation
import SwiftUI
import SwiftData

@Observable
final class DetailsViewModel {
    var profile: BabyProfile

    init(profile: BabyProfile) {
        self.profile = profile
    }

    // MARK: - Bindings

    var nameBinding: Binding<String> {
        Binding(
            get: { self.profile.fullName },
            set: { self.profile.fullName = $0 }
        )
    }

    var birthdayBinding: Binding<Date> {
        Binding(
            get: { self.profile.birthday },
            set: { self.profile.birthday = $0 }
        )
    }

    var imageBinding: Binding<UIImage?> {
        Binding(
            get: {
                if let data = self.profile.imageData {
                    return UIImage(data: data)
                }
                return nil
            },
            set: {
                if let newImage = $0 {
                    self.profile.imageData = newImage.jpegData(compressionQuality: 0.9)
                } else {
                    self.profile.imageData = nil
                }
            }
        )
    }

    // MARK: - Validation

    // Name
    var isNameValid: Bool {
        nameValidationError == nil
    }
    
    var nameValidationErrorDescription: String? {
        nameValidationError?.errorDescription
    }
    
    var nameValidationError: NameValidationError? {
        let trimmed = profile.fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let parts = trimmed.components(separatedBy: .whitespaces).filter { !$0.isEmpty }

        // field shouldn't be empty
        if trimmed.isEmpty {
            return .empty
        }

        let patternOnlyLetters = #"^[\p{L}]+$"#

        for part in parts {
            // no special symbols allowed
            if part.range(of: patternOnlyLetters, options: .regularExpression) == nil {
                return .invalidCharacters
            }
            // more than 2 symbols required
            if part.count < 2 {
                return .tooShort
            }
        }
        
        // fullname should be consistent of two words - name and surname
        if parts.count < 2 {
            return .notEnoughParts
        }
        
        // name is valid
        return nil
    }

    // Birthday
    var isBirthdayValid: Bool {
        birthdayErrorMessage == nil
    }
    
    var birthdayErrorMessage: String? {
        let date = profile.birthday
        let now = Date()

        // no future dates
        if date > now {
            return "birthday_error_future".localized
        }

        let calendar = Calendar.current
        
        // should be under 5 years old
        if let age = calendar.dateComponents([.year], from: date, to: now).year {
            if age > 5 {
                return "birthday_error_too_old".localized
            }
        }

        return nil
    }

    // Form
    var isFormValid: Bool {
        isNameValid && isBirthdayValid
    }
}
