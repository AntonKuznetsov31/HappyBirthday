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
    private var viewModel: BirthdayScreenViewModel
    
    /// Task requirement: apply a random theme on every screen visit (not persisted)
    private var theme = AppColorTheme.random()
    
    // Uncomment to use global app theme
    // @Environment(\.birthdayTheme) private var theme
    
    @Environment(\.displayScale) var displayScale
    @State private var image: UIImage?
    
    init(viewModel: BirthdayScreenViewModel) {
        self.viewModel = viewModel
    }
    
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
                if viewModel.profile.imageData != nil {
                    renderImageToShare()
                }
            }
    }
    
    /// Image rendering for content sharing
    @MainActor func renderImageToShare() {
        let size = UIScreen.main.bounds.size
        let renderer = ImageRenderer(content:
                                        content(isItToShare: true)
            .frame(width: size.width, height: size.height)
            .environment(\.displayScale, displayScale)
        )
        
        renderer.scale = displayScale
        
        if let rendered = renderer.uiImage {
            image = rendered
        } else {
            print("Failed to render snapshot")
        }
    }
    
    /// Main content layout split into top info and bottom image/logo area
    private func content(isItToShare: Bool) -> some View {
        ZStack {
            theme.backgroundColor
                .ignoresSafeArea()
            
            backgroundView
            
            VStack {
                VStack {
                    titleView
                        .padding(.bottom, 13)
                    swirlsAndDigitView
                    subtitleView
                        .padding(.top, 14)
                }
                .padding(.horizontal, 20)
                VStack {
                    photoPicker(isItToShare)
                        .padding(.bottom, 15)
                    logoView
                        .padding(.bottom, 53)
                    if !isItToShare {
                        shareButton
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .padding(.bottom, 53)
        }
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
                Spacer()
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
            .padding(.horizontal, 20)
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
                if let data = viewModel.profile.imageData {
                    return UIImage(data: data)
                }
                return nil
            },
            set: { newImage in
                viewModel.profile.imageData = newImage?.jpegData(compressionQuality: 0.9)
            }
        ), isIconHidden: isIconHidden)
        .padding(.horizontal, 50)
    }
    
    /// Sharin screen content button
    private var shareButton: some View {
        Group {
            if let image = image {
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
            } else {
                ProgressView()
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

