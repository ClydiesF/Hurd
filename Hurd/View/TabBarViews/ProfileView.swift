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
        VStack(spacing: 0) {
            Group {
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
                
                HStack {
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
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(dataTags, id: \.self) { itemName in
                        TagView(tagName: itemName)
                    }
                }
                .padding(.bottom, 10)
                
                
                Text("I love to travel to nice places and being able to hang out with a bunch of ppl. I like to drink and party hard like the rest of us. I love it so much. ")
                    .font(.caption)
            }
            .padding(.horizontal)
            
            // Slider //
            // Slider View
            HurdSlidingTabView(selection: $selectedTabIndex, tabs: tabs,activeAccentColor: .bottleGreen, selectionBarColor: .bottleGreen)
            
            switch self.selectedTabIndex {
            case 0: Color.bottleGreen.ignoresSafeArea()
            case 1:  Color.red.ignoresSafeArea()
            case 2:  Color.blue.ignoresSafeArea()
            case 3:  Color.gray.ignoresSafeArea()
            case 4:  Color.purple.ignoresSafeArea()
                
            default:
                Color.black.ignoresSafeArea()
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
