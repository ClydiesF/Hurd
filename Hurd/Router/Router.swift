//
//  Router.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/18/23.
//

import Foundation
import SwiftUI

enum Destination: Codable, Hashable {
    case profile
    case groupPlannerView(trip: Trip, hurd: Hurd)
    
    public static func == (lhs: Destination, rhs: Destination) -> Bool {
        return true
    }
    
    public func hash(into hasher: inout Hasher) {
        switch self {
        case .profile:
            hasher.combine(1)
        case .groupPlannerView:
            hasher.combine(2)
        }
    }
}

final class Router: ObservableObject {
    
    @Published var navPath = NavigationPath()
    
    func navigate(to destination: Destination) {
        navPath.append(destination)
    }
    
    func navigateBack() {
        navPath.removeLast()
    }
    
    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
    
}

