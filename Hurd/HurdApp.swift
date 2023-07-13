//
//  HurdApp.swift
//  Hurd
//
//  Created by clydies freeman on 12/27/22.
//

import SwiftUI
import Firebase
import BranchSDK


@main
struct HurdApp: App {
    @StateObject var authVM = AuthenticationViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    
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
                            .onOpenURL(perform: { url in
                                  Branch.getInstance().handleDeepLink(url)
                              })
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
