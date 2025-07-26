//
//  NavigationCoordinator.swift
//  HappyBirthday
//
//  Created by Anton Kuznetsov on 26.07.2025.
//

import Foundation

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

@MainActor
final class NavigationCoordinator: ObservableObject {
    @Published var path: [AppRoute] = []
    
    func push(_ route: AppRoute) {
        path.append(route)
    }
    
    func pop() {
        _ = path.popLast()
    }
    
    func popToRoot() {
        path.removeAll()
    }
}
