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
//            GenerativeAIView(vm: .init(generativeAIModel:
//                    .init(name: "gemini-pro", apiKey: "AIzaSyB7qBUrXEudDiwyB3lZf3GUtobcS7VdXyI"), trip: Trip.mockTrip), itinVM: ItineraryViewModel(itinerary: Itinerary.mockItinerary, tripId: "434343"))
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

