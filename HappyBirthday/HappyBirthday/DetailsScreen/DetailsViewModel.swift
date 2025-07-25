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
}
