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

    private let size: CGFloat = 220
    private let iconSize: CGFloat = 36
    private let borderWidth: CGFloat = 7

    var body: some View {
        GeometryReader { geo in
            let center = CGPoint(x: geo.size.width / 2, y: geo.size.height / 2)
            let radius = size / 2
            ZStack {
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
                .frame(width: size, height: size)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(theme.borderColor, lineWidth: borderWidth)
                )
                .position(center)

                Button {
                    showSourceMenu = true
                } label: {
                    Image(theme.cameraIcon)
                        .resizable()
                        .frame(width: iconSize, height: iconSize)
                        .background(Color.white)
                        .clipShape(Circle())
                }
                .position(
                    x: center.x + radius * cos(.pi / 4),
                    y: center.y - radius * sin(.pi / 4)
                )
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
            .frame(width: geo.size.width, height: geo.size.height)
        }
        .frame(height: 250)
    }
}

