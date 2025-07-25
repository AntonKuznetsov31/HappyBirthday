//
//  AppColorTheme.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI

enum AppColorTheme: String, CaseIterable, Codable {
    case green
    case yellow
    case blue
    
    var backgroundColor: Color {
        switch self {
        case .green: return Color("background_color_green")
        case .yellow: return Color("background_color_yellow")
        case .blue: return Color("background_color_blue")
        }
    }

    var backgroundImage: String {
        switch self {
        case .green: return "background_green"
        case .yellow: return "background_yellow"
        case .blue: return "background_blue"
        }
    }

    var placeholderImage: String {
        switch self {
        case .green: return "placeholder_image_green"
        case .yellow: return "placeholder_image_yellow"
        case .blue: return "placeholder_image_blue"
        }
    }

    var cameraIcon: String {
        switch self {
        case .green: return "camera_icon_green"
        case .yellow: return "camera_icon_yellow"
        case .blue: return "camera_icon_blue"
        }
    }
    
    var borderColor: Color {
        switch self {
        case .green: return Color("border_сolor_green")
        case .yellow: return Color("border_color_yellow")
        case .blue: return Color("border_color_blue")
        }
    }
}

extension AppColorTheme {
    static func random() -> AppColorTheme {
        allCases.randomElement()!
    }
}

