//
//  HurdApp.swift
//  Hurd
//
//  Created by clydies freeman on 12/27/22.
//

import SwiftUI
import Firebase


@main
struct HurdApp: App {
    @StateObject var authVM = AuthenticationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            switch authVM.authState {
            case .signedIn:
                if let user = authVM.user {
                    if user.isFinishedOnboarding {
                        ContentView()
                            .environmentObject(authVM)
                    } else {
                        OnboardingSliderView()
                            .environmentObject(authVM)
                    }
                }
            case .signedOut:
                HurdLandingView()
                   .environmentObject(authVM)
            }
        }
    }
}
