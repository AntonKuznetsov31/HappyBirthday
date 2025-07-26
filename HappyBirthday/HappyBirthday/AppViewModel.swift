//
//  AppViewModel.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI
import SwiftData

/// The root view model of the app, responsible for loading or creating the `BabyProfile` and managing navigation.
@MainActor
final class AppViewModel: ObservableObject {
    
    /// The app's navigation coordinator used for pushing/popping views.
    let coordinator = NavigationCoordinator()
    
    /// The currently loaded baby profile, either fetched from storage or newly created.
    @Published var profile: BabyProfile?
    
    /// Starts the app by trying to fetch the baby profile from storage.
    /// If not found, it creates and saves a new empty profile.
    func start(context: ModelContext) async {
        do {
            let all = try context.fetch(FetchDescriptor<BabyProfile>())
            if let existing = all.first {
                profile = existing
            } else {
                let new = BabyProfile(fullName: "", birthday: .now)
                context.insert(new)
                try context.save()
                profile = new
            }
        } catch {
            print("Error fetching profile: \(error)")
        }
    }
}

