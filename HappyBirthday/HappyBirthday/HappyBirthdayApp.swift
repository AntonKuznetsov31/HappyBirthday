//
//  HappyBirthdayApp.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 25.07.2025.
//

import SwiftUI

@main
struct HappyBirthdayApp: App {
    @StateObject private var appViewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            AppEntryPoint()
                .environmentObject(appViewModel)
                .environmentObject(appViewModel.coordinator)
        }
        .modelContainer(for: BabyProfile.self)
    }
}
