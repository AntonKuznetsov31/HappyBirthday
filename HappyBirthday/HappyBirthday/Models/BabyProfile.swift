//
//  BabyProfile.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import Foundation
import SwiftData

@Model
class BabyProfile {
    var fullName: String
    var birthday: Date
    var imageData: Data?

    init(fullName: String = "", birthday: Date = Date(), imageData: Data? = nil) {
        self.fullName = fullName
        self.birthday = birthday
        self.imageData = imageData
    }
}

