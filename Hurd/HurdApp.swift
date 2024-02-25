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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var router = Router()
    
    
    var body: some Scene {

        WindowGroup {
//            GenerativeAIView()
            switch authVM.authState {
            case .signedIn:
                ContentView()
                    .environmentObject(authVM)
                    .environmentObject(router)
            case .signedOut:
                LandingView()
                    .environmentObject(authVM)
            }
        }
    }
}

