//
//  BirthdayScreenViewModel.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import UIKit
import SwiftUI

@MainActor
final class BirthdayScreenViewModel: ObservableObject {
    
    var profile: BabyProfile
    
    /// Age display calculated from birthday, shown as text and image
    @Published var ageDisplay: BabyAgeDisplay
    
    var onBackTapped: () -> Void = {}
    
    /// Title text displayed on the screen, e.g. "Today is Alice's Birthday"
    var titleText: String {
        String(
            format: NSLocalizedString("today_title", comment: ""),
            profile.fullName.uppercased()
        )
    }

    /// Subtitle with age, e.g. "2 YEARS" or "11 MONTHS"
    var subtitleText: String {
        ageDisplay.formattedText
    }

    /// Asset name for the digit image, used to show age number
    var digitAssetName: String {
        ageDisplay.digitAssetName
    }

    init(profile: BabyProfile) {
        self.profile = profile
        self.ageDisplay = BabyAgeCalculator.calculate(from: profile.birthday)
    }
}

