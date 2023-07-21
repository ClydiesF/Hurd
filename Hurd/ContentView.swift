//
//  ContentView.swift
//  Hurd
//
//  Created by clydies freeman on 12/27/22.
//

import SwiftUI
import FirebaseAuth
import BranchSDK

struct ContentView: View {
    
    @State var selection = 0
    @EnvironmentObject var authVM: AuthenticationViewModel
    @State private var path: [Destination] = []

    var body: some View {
        NavigationStack(path: $path) {
                TabView(selection: $selection) {
                    TripView().tabItem {
                        Image(systemName: "globe")
                        Text("Home")
                    }.tag(0)
                    
                    DiscoveryView().tabItem {
                        Image(systemName: "gearshape.fill")
                        Text("Settings")
                    }.tag(1)
                    
                    ProfileView(vm: ProfileViewModel(user: authVM.user!)).tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }.tag(2)
                }
                .accentColor(.bottleGreen)
                .background(Color.white)
                .onAppear {
                    let appearance = UITabBarAppearance()
                    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
                    appearance.backgroundColor = UIColor(Color.white.opacity(0.2))
                    
                    // Use this appearance when scrolling behind the TabView:
                    UITabBar.appearance().standardAppearance = appearance
                    // Use this appearance when scrolled all the way up:
                    UITabBar.appearance().scrollEdgeAppearance = appearance
                }
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .groupPlannerView(let trip, let hurd):
                    GroupPlannerView(vm:GroupPlannerViewModel(trip: trip, hurd: hurd))
                case .profile:
                    ProfileView(vm: ProfileViewModel(user: User.mockUser1))
                }
            }
            .onOpenURL(perform: { url in
                // Need Both
                Branch.getInstance().handleDeepLink(url)
                Branch.getInstance().initSession(isReferrable: true) { (params, error) in
                    print("DEBUG: params String \(params as? [String: AnyObject] ?? [:])")
                    guard let paramDict = params as? [String: AnyObject] else { return }
                    
                    if paramDict["nav_to"] as? String == "groupPlannerView" {
                        guard let tripID = paramDict["tripID"], let hurdID = paramDict["hurdID"] else { return }
                        
                        print("DEBUG: trip \(tripID), hurd: \(hurdID)")
                        
                        let nc = NetworkCalls()
                        Task {
                            guard let trip = await nc.fetchTrip(with: tripID as! String),
                                  let hurd = await nc.fetchHurd(with: hurdID as! String) else { return }
                            
                            path.append(.groupPlannerView(trip: trip, hurd: hurd))
                            //router.navigate(to: .groupPlannerView(trip: trip, hurd: hurd))
                        }
                    }
                }
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(AuthenticationViewModel())
    }
}
