//
//  AppEntryPoint.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI
import SwiftData

/// The main entry point of the app after launch.
/// It loads the user's profile and shows either the `DetailsScreenView`
/// or a `ProgressView` while loading data.
struct AppEntryPoint: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var appViewModel: AppViewModel
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    var body: some View {
        Group {
            // Once the profile is loaded, show the main navigation stack
            if let profile = appViewModel.profile {
                NavigationStack(path: $coordinator.path) {
                    DetailsScreenView(viewModel: DetailsScreenViewModel(profile: profile))
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .birthday(let id):
                                if let profile = try? modelContext.fetch(FetchDescriptor<BabyProfile>()).first(where: { $0.id == id }) {
                                    BirthdayScreenView(viewModel: {
                                        let vm = BirthdayScreenViewModel(profile: profile)
                                        vm.onBackTapped = { coordinator.pop() }
                                        return vm
                                    }())
                                } else {
                                    Text("Profile not found")
                                }
                            }
                        }
                }
            } else {
                // While loading the profile, show progress indicator
                ProgressView()
            }
        }
        .task {
            // Load or create the user's profile from SwiftData
            await appViewModel.start(context: modelContext)
        }
    }
}
