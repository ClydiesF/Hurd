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
        NavigationStack {
            VStack(spacing: 8) {
                ZStack {
                    Rectangle()
                        .fill(Color.bottleGreen)
                        .ignoresSafeArea()

                    VStack {
                        Spacer()
                        Image("mockAvatarImage")
                            .resizable()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())

                        Text("Boomy Freeman")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)

                        Text("Joined Jan 2011")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(.vertical,5)
                            .padding(.horizontal,15)
                            .background(Capsule().fill(Color.black.opacity(0.5)))
                            .padding(.bottom, Spacing.twentyone)

                    }
                }
                .frame(height: UIScreen.main.bounds.size.height * 0.3)
                
                HStack {
                    VStack(alignment: .leading, spacing: Spacing.eight) {
                        Label("617-233-1242", systemImage: "phone.fill")
                            .font(.system(size: 14))
                        
                        Label("Boston, MA", systemImage: "location.fill")
                            .font(.system(size: 14))
                        
                        Label("c.edward.freeman@gmail.com", systemImage: "envelope.fill")
                            .font(.system(size: 14))
                            .tint(.black)
                        
                        Text("He/Him")
                            .font(.system(size: 14))
                        
                        Text("African-American")
                            .font(.system(size: 14))
                    }
                    Spacer()
                }
                .padding(.horizontal, Spacing.twentyone)
     
                Text("I Love to travel to nice placesd and being able to hang out witha bunch of ppl. I Like to drink and part hard like the rest of us. i Love it so much,")
                    .font(.system(size: 14))
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, Spacing.twentyone)
        
      
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
               
                    NavigationLink {
                        EmptyView()
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.white)
                    }}
            }
        }
      
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
