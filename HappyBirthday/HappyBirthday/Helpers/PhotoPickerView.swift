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
    @Binding var image: UIImage?
    @State private var pickerSource: ImagePickerSource?
    @State private var showSourceMenu = false
    let isIconHidden: Bool
    
    @Environment(\.birthdayTheme) private var theme
    
    private let iconSize: CGFloat = 36
    private let borderWidth: CGFloat = 7
    let diameterRatio: CGFloat = 0.5
    
    private var diameter: CGFloat {
        UIScreen.main.bounds.width * diameterRatio
    }
    
    private var radius: CGFloat { diameter / 2 }
    private var iconRadius: CGFloat { iconSize / 2 }
    private var diagonalOffset: CGFloat { radius * cos(.pi / 4) }
    
    private var iconOffset: CGSize {
        let offset = radius + iconSize / 2
        let dx = offset * cos(.pi / 4)
        let dy = offset * sin(.pi / 4)
        return CGSize(width: dx - 10, height: -dy + 10)
    }
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
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .offset(iconOffset)
            }
        }
        .frame(width: diameter, height: diameter)
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
