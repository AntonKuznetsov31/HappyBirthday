//
//  PhotoPickerView.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI
import UIKit

enum ImagePickerSource: Identifiable {
    case camera
    case photoLibrary

    var id: Int { hashValue }
}

struct PhotoPickerView: View {
    
    /// Binding to the selected image.
    @Binding var image: UIImage?
    
    /// Currently selected image picker source (camera or library).
    @State private var pickerSource: ImagePickerSource?
    
    /// Flag to control visibility of the source selection menu.
    @State private var showSourceMenu = false
    
    /// Whether the camera icon should be hidden (for sharing)
    let isIconHidden: Bool
    
    @Environment(\.birthdayTheme) private var theme
    
    // MARK: - Constants
    private let iconSize: CGFloat = 36
    private let borderWidth: CGFloat = 7
    
    /// Ratio of the diameter of the avatar to the screen width.
    private let diameterRatio: CGFloat = 0.5
    
    /// Diameter of the avatar circle.
    private var diameter: CGFloat {
        UIScreen.main.bounds.width * diameterRatio
    }
    
    /// Radius of the avatar circle.
    private var radius: CGFloat { diameter / 2 }
    
    /// Radius of the camera icon circle.
    private var iconRadius: CGFloat { iconSize / 2 }
    
    /// Distance from the center of the avatar to the icon center (placed diagonally).
    private var diagonalOffset: CGFloat { radius * cos(.pi / 4) }
    
    /// Final offset for the camera icon (placed on top-right edge of the avatar).
    private var iconOffset: CGSize {
        let offset = radius + iconSize / 2
        let dx = offset * cos(.pi / 4)
        let dy = offset * sin(.pi / 4)
        return CGSize(width: dx - 10, height: -dy + 10)
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            // Avatar circle
            ZStack {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    Image(theme.placeholderImage)
                        .resizable()
                        .scaledToFill()
                }
            }
            .frame(width: diameter, height: diameter)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(theme.borderColor, lineWidth: borderWidth)
            )

            // Camera icon
            if !isIconHidden {
                Button {
                    showSourceMenu = true
                } label: {
                    Image(theme.cameraIcon)
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                        .background(theme.borderColor)
                        .clipShape(Circle())
                }
                .offset(iconOffset)
            }
        }
        .frame(width: diameter, height: diameter)
        
        // Source Selection & Sheet
        .confirmationDialog("choose_photo_source".localized, isPresented: $showSourceMenu, titleVisibility: .visible) {
            Button("camera_title".localized) {
                pickerSource = .camera
            }
            Button("photo_library_title".localized) {
                pickerSource = .photoLibrary
            }
        }
        .sheet(item: $pickerSource) { source in
            ImagePicker(sourceType: source == .camera ? .camera : .photoLibrary) { pickedImage in
                image = pickedImage
            }
        }
    }
}
