//
//  BirthdayScreenView.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftData
import SwiftUI

/// Birthday screen displaying themed congratulations and profile photo.
struct BirthdayScreenView: View {
    
    @ObservedObject private var viewModel: BirthdayScreenViewModel
    
    @Environment(\.birthdayTheme) private var theme
    
    @Environment(\.displayScale) var displayScale
    
    init(viewModel: BirthdayScreenViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        content(isItToShare: false)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    backButton
                }
            }
            .task {
                renderShareableContent()
            }
    }
    
    /// Main content layout
    private func content(isItToShare: Bool) -> some View {
        ZStack {
            theme.backgroundColor
                .ignoresSafeArea()
            
            ZStack(alignment: .bottom) {
                backgroundView
                    .zIndex(1)
                VStack {
                    Spacer()
                    VStack {
                        titleView
                            .frame(width: 220)
                            .padding(.bottom, 13)
                        swirlsAndDigitView
                            .padding(.bottom, 14)
                        subtitleView
                    }
                    .padding(.horizontal, 50)
                    Spacer()
                    photoPicker(isItToShare)
                        .padding(.top, 20)
                        .padding(.bottom, 200)
                        .zIndex(0)
                }
            }
            
            VStack {
                Spacer()
                VStack {
                    logoView
                        .padding(.bottom, 53)
                    if !isItToShare {
                        shareButton
                            .padding(.bottom, 53)
                    }
                }
                .padding(.horizontal, 50)
            }
        }
    }
    
    /// Content rendering method
    private func renderShareableContent() {
        viewModel.renderImageToShare(content: content(isItToShare: true), displayScale: displayScale)
    }
    
    // MARK: - UI elements
    
    /// Custom back button used in the toolbar
    private var backButton: some View {
        HStack {
            Button(action: {
                viewModel.onBackTapped()
            }) {
                HStack(spacing: 4) {
                    Image("back_button_icon")
                        .font(.system(size: 17, weight: .medium))
                }
                .foregroundColor(.black)
            }
            Spacer()
        }
        .frame(width: 24, height: 24)
    }
    
    /// Background image
    private var backgroundView: some View {
        GeometryReader { geo in
            VStack {
                Image(theme.backgroundImage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geo.size.width)
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea()
        }
    }
    
    /// Birthday greeting title text
    private var titleView: some View {
        Text(viewModel.titleText)
            .font(.system(size: 21, weight: .regular))
            .multilineTextAlignment(.center)
            .lineLimit(2...)
            .truncationMode(.tail)
            .frame(maxWidth: .infinity)
    }
    
    /// Age digit with decorative swirls left and right
    private var swirlsAndDigitView: some View {
        HStack(spacing: 22) {
            Image("swirls_left")
                .resizable()
                .frame(width: 50, height: 43)
            
            Image(viewModel.digitAssetName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 87)
            
            Image("swirls_right")
                .resizable()
                .frame(width: 50, height: 43)
        }
    }
    
    /// Subtitle below age indicator
    private var subtitleView: some View {
        Text(viewModel.subtitleText)
            .font(.system(size: 21, weight: .regular))
    }
    
    /// Circular photo picker, optionally hiding the camera icon for snapshots
    private func photoPicker(_ isIconHidden: Bool) -> some View {
        PhotoPickerView(image: Binding(
            get: {
                if let data = viewModel.imageData {
                    return UIImage(data: data)
                }
                return nil
            },
            set: { newImage in
                viewModel.setImageData(newImage?.jpegData(compressionQuality: 0.9))
                renderShareableContent()
            }
        ), isIconHidden: isIconHidden)
    }
    
    /// Sharin screen content button
    private var shareButton: some View {
        Group {
            if let image = viewModel.renderedImage {
                ShareLink(
                    item: Image(uiImage: image),
                    preview: SharePreview(Text("Shared image"), image: Image(uiImage: image))
                ) {
                    HStack {
                        Text("share_button_title".localized)
                        Image("share_button_icon")
                            .font(.system(size: 16))
                    }
                    .fontWeight(.semibold)
                    .frame(width: 180)
                    .frame(height: 42)
                    .background(Color("primary_button_color"))
                    .foregroundColor(.white)
                    .cornerRadius(42)
                }
            }
        }
    }
    
    /// Branding logo at the bottom
    private var logoView: some View {
        Image("nanit_logo")
            .resizable()
            .frame(width: 59, height: 20)
    }
}

