//
//  DetailsScreenViewModel.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import Foundation
import SwiftUI
import SwiftData

final class DetailsScreenViewModel: ObservableObject {
    
    /// User profile model
    private var profile: BabyProfile
    
    /// Callback triggered when user taps "Show birthday screen".
    var onShowBirthdayScreenTapped: () -> Void = {}
    
    /// User profile ID
    var profileID: UUID {
        profile.id
    }

    init(profile: BabyProfile) {
        self.profile = profile
    }

    // MARK: - Bindings

    /// Binding to the baby's full name, used by a TextField.
    var nameBinding: Binding<String> {
        Binding(
            get: { self.profile.fullName },
            set: { self.profile.fullName = $0 }
        )
    }

    /// Binding to the baby's birthday date, used by a DatePicker.
    var birthdayBinding: Binding<Date> {
        Binding(
            get: { self.profile.birthday },
            set: { self.profile.birthday = $0 }
        )
    }

    /// Binding to the baby's photo, used by a photo picker.
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

    /// Indicates whether the name is valid.
    var isNameValid: Bool {
        nameValidationError == nil
    }
    
    /// Localized error description for name field (used in UI).
    var nameValidationErrorDescription: String? {
        nameValidationError?.errorDescription
    }
    
    /// Validates the full name: must contain two parts, no digits/symbols, minimum 2 letters each.
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

    /// Indicates whether the birthday is valid.
    var isBirthdayValid: Bool {
        birthdayErrorMessage == nil
    }
    
    /// Localized error message for invalid birthday (used in UI).
    var birthdayErrorMessage: String? {
        let date = profile.birthday
        let now = Date()

        // No future dates allowed
        if date > now {
            return "birthday_error_future".localized
        }

        let calendar = Calendar.current
        
        // Child must be under 5 years old
        if let age = calendar.dateComponents([.year], from: date, to: now).year {
            if age > 5 {
                return "birthday_error_too_old".localized
            }
        }

        return nil
    }

    /// Returns whether the entire form is valid.
    var isFormValid: Bool {
        isNameValid && isBirthdayValid
    }
}
