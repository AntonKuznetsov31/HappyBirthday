//
//  NavigationCoordinator.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import Foundation

/// Enum describing navigation routes used in the app.
/// Conforms to `Hashable` to work with `NavigationStack`.
enum AppRoute: Hashable {
    case birthday(id: UUID)
    
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        switch (lhs, rhs) {
        case let (.birthday(id1), .birthday(id2)):
            return id1 == id2
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .birthday(let id):
            hasher.combine("birthday")
            hasher.combine(id)
        }
    }
}


/// A navigation coordinator that manages the app's navigation stack.
@MainActor
final class NavigationCoordinator: ObservableObject {
    @Published var path: [AppRoute] = []
    
    /// Pushes a new route onto the navigation stack.
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    /// Pops the top route from the navigation stack.
    func pop() {
        _ = path.popLast()
    }
    
    /// Pops all routes and returns to the root view (DetailsScreenView in our case)
    func popToRoot() {
        path.removeAll()
    }
}
