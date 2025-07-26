//
//  AppViewModel.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import SwiftUI
import SwiftData

@MainActor
final class AppViewModel: ObservableObject {
    let coordinator = NavigationCoordinator()
    @Published var profile: BabyProfile?
    
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

