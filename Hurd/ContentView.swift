//
//  ContentView.swift
//  Hurd
//
//  Created by clydies freeman on 12/27/22.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    
    @State var selection = 0
    @State var addTripFormPresented: Bool = false
    @EnvironmentObject var authVM: AuthenticationViewModel

    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            
            // 1
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
            
            
            //2
            Button {
                addTripFormPresented = true
            } label: {
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            .padding()
            .background(Color.bottleGreen)
            .clipShape(Circle())
            .shadow(radius: 4, x: 3, y:3)
            .offset(x: -Spacing.twentyfour, y: -Spacing.sixtyfour)
   
        }
        .sheet(isPresented: $addTripFormPresented) {
            AddTripFormView(vm: AddTripFormViewModel())
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct FloatingTabbar: View {
    
    @Binding var selected: Int
    @State var expand = false
    
    var body: some View {
        HStack {
            
            Spacer(minLength: 0)
            HStack {
                
                if !self.expand {
                    Button {
                        self.expand.toggle()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                            .fontWeight(.black)
                            .padding(.horizontal)
                    }

                } else {
                    Button {
                        self.selected = 0
                    } label: {
                        Image("adventureIcon")
                            .renderingMode(.template)
                            .foregroundColor(self.selected == 0 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 1
                    } label: {
                        Image("searchIcon")
                            .renderingMode(.template)
                            .foregroundColor(self.selected == 1 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 2
                    } label: {
                        Image("plusIcon")
                            .renderingMode(.template)
                            .foregroundColor(self.selected == 2 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 3
                    } label: {
                        Image("chatIcon")
                            .renderingMode(.template)
                            .foregroundColor(self.selected == 3 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                    
                    Spacer(minLength: 15)
                    
                    Button {
                        self.selected = 4
                    } label: {
                        Image("chatIcon")
                            .renderingMode(.template)
                           .foregroundColor(self.selected == 4 ? .bottleGreen : .white)
                            .padding(.horizontal)
                    }
                }
                

            }
            .padding()
            .background(Color.black.opacity(0.5))
            .clipShape(Capsule())
            .padding(.horizontal)
            .onLongPressGesture {
                self.expand.toggle()
            }
            .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.6, blendDuration: 0.6), value: expand)
        }
      
    }
}
