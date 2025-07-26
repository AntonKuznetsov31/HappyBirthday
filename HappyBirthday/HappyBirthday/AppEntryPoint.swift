//
//  AppEntryPoint.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI
import SwiftData

struct AppEntryPoint: View {
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject private var appViewModel: AppViewModel
    @EnvironmentObject private var coordinator: NavigationCoordinator
    
    var body: some View {
        Group {
            if let profile = appViewModel.profile {
                NavigationStack(path: $coordinator.path) {
                    DetailsScreenView(viewModel: DetailsScreenViewModel(profile: profile))
                        .navigationDestination(for: AppRoute.self) { route in
                            switch route {
                            case .birthday(let id):
                                // TODO: Birthday screen
                                Text("Birthday Screen")
                            }
                        }
                }
            } else {
                ProgressView()
            }
        }
        .task {
            await appViewModel.start(context: modelContext)
        }
    }
}
