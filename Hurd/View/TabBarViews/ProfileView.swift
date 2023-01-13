//
//  ProfileView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI

struct ProfileView: View {
    
    let dataTags = ["Boston,MA","Joined Sept 2022","617-233-1242", "Born Sep 18, 2022","Partying"]
    
    @State private var selectedTabIndex = 0
    let tabs = ["globe.americas.fill",
                "rectangle.3.group",
    ]
    
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.horizontal)
            
            HStack(alignment: .top, spacing: 0) {
                ZStack(alignment: .topTrailing) {
                    Image("mockAvatarImage")
                        .resizable()
                        .frame(width: 120, height: 150)
                        .cornerRadius(10)
                    
                    
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.bottleGreen)
                        .font(.title3)
                        .offset(x: 10, y: -10)
                }
 
                Spacer()
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Boomy Freeman")
                        .font(.title3)
                        .fontWeight(.bold)
                    
                    Text("I love to travel to nice places and being able to hang out with a bunch of ppl. I like to drink and party hard like the rest of us. I love it so much.")
                        .font(.caption)
                        .multilineTextAlignment(.center)
                        .padding(10)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.top, 5)
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
            .frame(height: 160)
            
            HStack {
         
                   Label("Boston, MA", systemImage: "mappin")
                        .font(.caption)
                        .padding(5)
                        .background(Capsule().stroke(Color.gray,lineWidth: 1))
                
                Label("Sept 2022", systemImage: "birthday.cake.fill")
                     .font(.caption)
                     .padding(5)
                     .background(Capsule().stroke(Color.gray,lineWidth: 1))
                
                Label("617-233-1242", systemImage: "phone")
                     .font(.caption)
                     .padding(5)
                     .background(Capsule().stroke(Color.gray,lineWidth: 1))
              
            
            }

            // Slider ////
            HurdSlidingTabView(selection: $selectedTabIndex, tabs: tabs,activeAccentColor: .bottleGreen, selectionBarColor: .bottleGreen)
//            Picker("What is your favorite color?", selection: $selectedTabIndex) {
//                Image(systemName: "globe.americas")
//                    .tag(0)
//                Image(systemName: "rectangle.3.group.bubble.left").tag(1)
//
//            }
//            .pickerStyle(.segmented)// Slider View
            
            switch self.selectedTabIndex {
            case 0: Color.bottleGreen.ignoresSafeArea()
            case 1: Color.red.ignoresSafeArea()
            default: Color.black.ignoresSafeArea()
            }
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
