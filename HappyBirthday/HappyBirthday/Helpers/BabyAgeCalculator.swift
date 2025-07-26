//
//  BabyAgeCalculator.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import Foundation

struct BabyAgeCalculator {
    
    /// Calculates the age display value from a given birth date to the current date.
    /// - Returns: A `BabyAgeDisplay` representing the age in months (1–11) or years (1–5).
    static func calculate(from birthDate: Date, to now: Date = .now) -> BabyAgeDisplay {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: birthDate, to: now)

        if let years = components.year, years >= 1 {
            return .years(min(years, 5))
        }

        if let months = components.month {
            return .months(min(months, 11))
        }

        return .months(1)
    }
}

/// Represents a displayable version of baby's age, either in months or years.
enum BabyAgeDisplay {
    case months(Int)
    case years(Int)

    /// A localized, capitalized string to show the age (e.g. "3 MONTHS OLD", "2 YEARS OLD").
    var formattedText: String {
        switch self {
        case .months(let months):
            let format = String.localizedStringWithFormat(
                NSLocalizedString("age_months_format", comment: "Age in months"),
                months
            )
            return format.uppercased()
        case .years(let years):
            let format = String.localizedStringWithFormat(
                NSLocalizedString("age_years_format", comment: "Age in years"),
                years
            )
            return format.uppercased()
        }
    }

    /// Returns the asset name for the age digit image (e.g. "digit_3").
    /// Maximum value is clamped to 12.
    var digitAssetName: String {
        let value = numericValue
        return "digit_\(min(value, 12))"
    }

    /// Returns the numeric value of age regardless of type.
    var numericValue: Int {
        switch self {
        case .months(let m): return m
        case .years(let y): return y
        }
    }

    /// Represents whether the age is measured in months or years.
    enum AgeType {
        case months, years
    }

    var type: AgeType {
        switch self {
        case .months: return .months
        case .years: return .years
        }
    }
}
