//
//  BirthdayTheme+Environment.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI

private struct BirthdayThemeKey: EnvironmentKey {
    static let defaultValue: AppColorTheme = .green
}

extension EnvironmentValues {
    var birthdayTheme: AppColorTheme {
        get { self[BirthdayThemeKey.self] }
        set { self[BirthdayThemeKey.self] = newValue }
    }
}
