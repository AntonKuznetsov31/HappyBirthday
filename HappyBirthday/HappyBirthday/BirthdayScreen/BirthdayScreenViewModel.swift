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
    
    /// User profile model
    private let profile: BabyProfile
    
    /// Age display calculated from birthday, shown as text and image
    @Published var ageDisplay: BabyAgeDisplay
    
    @Published var renderedImage: UIImage?
    
    var onBackTapped: () -> Void = {}
    
    /// Image data getter
    var imageData: Data? {
        profile.imageData
    }
    
    /// Image data setter
    func setImageData(_ data: Data?) {
        profile.imageData = data
    }
    
    /// Title text displayed on the screen, e.g. "Today Alice is ... old"
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
    
    /// Image rendering for content sharing
    @MainActor func renderImageToShare(content: some View, displayScale: CGFloat) {
        let size = UIScreen.main.bounds.size
        let renderer = ImageRenderer(content:
                                        content
            .frame(width: size.width, height: size.height)
            .environment(\.displayScale, displayScale)
        )
        
        renderer.scale = displayScale
        
        if let rendered = renderer.uiImage {
            renderedImage = rendered
        } else {
            print("Failed to render snapshot")
        }
    }

    init(profile: BabyProfile) {
        self.profile = profile
        self.ageDisplay = BabyAgeCalculator.calculate(from: profile.birthday)
    }
}

