//
//  DetailsScreenView.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI
import SwiftData

struct DetailsScreenContainer: View {
    
    @Environment(\.modelContext) private var context

    var body: some View {
        Group {
            let profile = fetchOrCreateProfile()
            DetailsScreenView(viewModel: DetailsViewModel(profile: profile))
        }
    }
    
    private func fetchOrCreateProfile() -> BabyProfile {
        if let existing = try? context.fetch(FetchDescriptor<BabyProfile>()).first {
            return existing
        } else {
            let new = BabyProfile(fullName: "", birthday: .now)
            context.insert(new)
            return new
        }
    }
}

struct DetailsScreenView: View {
    @Bindable var viewModel: DetailsViewModel
    @State private var isShowingBirthdayScreen = false
    
    @State private var imageToShare: UIImage?
        @State private var isSharing = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                title
                nameField
                birthdayField
                Spacer()
                showButton
            }
            .padding()
        }
    }
    
    private var title: some View {
        Text("app_title".localized)
            .font(.title)
            .bold()
    }
    
    private var nameField: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField("textfield_placeholder".localized, text: viewModel.nameBinding)
                .textFieldStyle(.roundedBorder)

        }
    }
    
    private var birthdayField: some View {
        VStack(alignment: .leading, spacing: 4) {
            DatePicker("birthday".localized, selection: viewModel.birthdayBinding, displayedComponents: .date)
                .tint(Color("primaryColor"))

        }
    }
    
    private var showButton: some View {
        Button {
            isShowingBirthdayScreen = true
        } label: {
            Text("show_birthday_screen".localized)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 42)
                .foregroundColor(.white)
                .cornerRadius(42)
        }
        .padding(.horizontal)
        .padding(.bottom, 53)
    }
}
