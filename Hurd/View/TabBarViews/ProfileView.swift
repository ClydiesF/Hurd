//
//  ProfileView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI

struct ProfileView: View {
    
    let dataTags = ["Boston,MA","Joined Sept 2022","617-233-1242", "Born Sep 18, 2022","Partying"]
    let columns = [
          GridItem(.fixed(130)),
          GridItem(.fixed(120)),
          GridItem(.fixed(120))
      ]
    
    @State private var selectedTabIndex = 0
    let tabs = ["globe.americas.fill",
                "rectangle.3.group",
    ]

    
    
    var body: some View {
        VStack(alignment: .leading) {
                
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.horizontal)
            
            HStack(alignment: .top) {
                HStack {
                    Image("mockAvatarImage")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .cornerRadius(50)
                    
                    VStack {
                        Image("verified")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                        Spacer()
                        
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .frame(height: 100)
                
                VStack(spacing:.zero) {
                    HStack(alignment: .firstTextBaseline) {
                        Text("Boomy Freeman")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.top, 20)
                        
                        Image(systemName: "qrcode")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    Text("@travelMaster13")
                        .foregroundColor(.gray)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                }
             
                Spacer()
            }
            .padding(.horizontal)
     
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(dataTags, id: \.self) { itemName in
                        TagView(tagName: itemName)
                    }
                }
                .padding(.leading)
           
            }
                LazyVGrid(columns: columns, spacing: 10) {
                
                }
                .padding(.bottom, 10)
                
                
                Text("I love to travel to nice places and being able to hang out with a bunch of ppl. I like to drink and party hard like the rest of us. I love it so much. ")
                    .font(.caption)
                    .padding(.horizontal)
                    .multilineTextAlignment(.center)
            
            // Slider //
            Picker("What is your favorite color?", selection: $selectedTabIndex) {
                 Image(systemName: "globe.americas")
                    .tag(0)
                Image(systemName: "rectangle.3.group.bubble.left").tag(1)
                
               }
               .pickerStyle(.segmented)// Slider View
            
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

//            HurdSlidingTabView(selection: $selectedTabIndex, tabs: tabs,activeAccentColor: .bottleGreen, selectionBarColor: .bottleGreen)
