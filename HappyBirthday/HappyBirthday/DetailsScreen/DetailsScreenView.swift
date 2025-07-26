//
//  DetailsScreenView.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI
import SwiftData

/// The root screen where the user enters baby’s details (name, birthday, and photo).
/// Once valid input is provided, user can proceed to the next birthday screen.
struct DetailsScreenView: View {
    @EnvironmentObject private var coordinator: NavigationCoordinator
    @Environment(\.birthdayTheme) private var theme
    @ObservedObject var viewModel: DetailsScreenViewModel
    
    @State private var imageToShare: UIImage?
    @State private var isSharing = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                title
                nameField
                birthdayField
                photoView
                Spacer()
                showButton
            }
            .padding()
        }
    }
    
    /// Title shown at the top of the screen
    private var title: some View {
        Text("app_title".localized)
            .font(.title)
            .bold()
    }
    
    /// Input field for the baby's full name, including inline validation
    private var nameField: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("textfield_placeholder".localized, text: viewModel.nameBinding)
                .textFieldStyle(.roundedBorder)
            if let error = viewModel.nameValidationErrorDescription {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            } else {
                Text(" ").font(.caption)
            }
        }
    }
    
    /// Input field for selecting the baby's birthday, with validation
    private var birthdayField: some View {
        VStack(alignment: .leading, spacing: 4) {
            DatePicker("birthday".localized, selection: viewModel.birthdayBinding, displayedComponents: .date)
                .tint(Color("primary_button_color"))
            if let error = viewModel.birthdayErrorMessage {
                Text(error)
                    .font(.caption)
                    .foregroundColor(.red)
            } else {
                Text(" ").font(.caption)
            }
        }
    }
    
    /// Button that becomes active when form is valid; navigates to the birthday screen
    private var showButton: some View {
        Button {
            coordinator.push(.birthday(id: viewModel.profile.id))
        } label: {
            Text("show_birthday_screen".localized)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .background(viewModel.isFormValid ? Color("primary_button_color") : Color.gray.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(42)
        }
        .disabled(!viewModel.isFormValid)
        .padding(.horizontal)
        .padding(.bottom, 53)
    }
    
    /// View that allows the user to pick a photo for the baby's profile
    private var photoView: some View {
        PhotoPickerView(image: viewModel.imageBinding, isIconHidden: false)
    }
}
