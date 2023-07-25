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
   // @State private var path: [Destination] = []
    @EnvironmentObject var router: Router



    var body: some View {
        HurdManagementView()
           
//                TabView(selection: $selection) {
//                    TripView().tabItem {
//                        Image(systemName: "globe")
//                        Text("Home")
//                    }.tag(0)
//
//
//                    DiscoveryView().tabItem {
//                        Image(systemName: "gearshape.fill")
//                        Text("Settings")
//                    }.tag(1)
//
//                    ProfileView(vm: ProfileViewModel(user: authVM.user!)).tabItem {
//                        Image(systemName: "person.crop.circle")
//                        Text("Profile")
//                    }.tag(2)
//                }
//                .accentColor(.bottleGreen)
//                .background(Color.white)
//                .onAppear {
//                    let appearance = UITabBarAppearance()
//                    appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
//                    appearance.backgroundColor = UIColor(Color.white.opacity(0.2))
//
//                    // Use this appearance when scrolling behind the TabView:
//                    UITabBar.appearance().standardAppearance = appearance
//                    // Use this appearance when scrolled all the way up:
//                    UITabBar.appearance().scrollEdgeAppearance = appearance
//                }

    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//       // ContentView()
//            //.environment(AuthenticationViewModel())
//    }
//}
