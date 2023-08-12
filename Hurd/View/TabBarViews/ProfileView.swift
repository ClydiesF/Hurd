//
//  ProfileView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State private var currentIndex = 0
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                
                TabView(selection: $currentIndex) {
                    ProfileInfoCardView(vm: vm)
                        .tag(0)
                    if vm.bio != nil {
                        VStack(alignment: .leading, spacing: Spacing.eight) {
                            HStack {
                                Image(systemName: "book.closed.fill")
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 13))
                                    .padding(8)
                                    .background(Circle().fill(.black.gradient))
                                Text("Travel Bio")
                                    .fontWeight(.semibold)
                                    .padding(.bottom, Spacing.eight)
                            }
                            Text(vm.bio)
                                .foregroundColor(.gray)
                        }.tag(1)
                    }
                    }
            
                .frame(height: 150)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .onChange(of: currentIndex) { newValue in
                     print("New page: \(newValue)")
                }
                .onTapGesture {
                    print("DEBUG: tap and go to trip View page")
                }
                
                HStack {
                    ForEach(0..<2) { i in
                        Circle()
                            .fill(i == currentIndex ? .black : .black.opacity(0.3))
                            .frame(width: 6, height: 6)
                        
                    }
                    .animation(.easeInOut, value: currentIndex)
                }
                
                ScrollableInfoView(vm: vm)
        
                Spacer()
            }
            .padding()
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
               
                    NavigationLink {
                        EditProfileView(vm: vm)
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
        ProfileView(vm: ProfileViewModel(user: User.mockUser1))
    }
}

struct ScrollableInfoView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                if vm.phoneNumber != "" {
                    Label(vm.phoneNumber, systemImage: "phone.fill")
                        .font(.system(size: 13))
                        .padding(Spacing.eight)
                        .background(Capsule().fill(.gray.opacity(0.1)))
                }
                
                
                Label("Boston, MA", systemImage: "location.fill")
                    .font(.system(size: 13))
                    .padding(Spacing.eight)
                    .background(Capsule().fill(.gray.opacity(0.1)))
                
                
                if let email = vm.user.emailAddress {
                    Label(email, systemImage: "envelope.fill")
                        .font(.system(size: 13))
                        .padding(Spacing.eight)
                        .background(Capsule().fill(.gray.opacity(0.1)))
                }
                
            }
        }
        .padding(Spacing.eight)
    }
}

struct ProfileInfoCardView: View {
    @ObservedObject var vm: ProfileViewModel
    var body: some View {
        HStack {
            HStack {

                    AsyncImage(url: URL(string: vm.user.profileImageUrl ?? ""), content: { image in
                        image
                            .resizable()
                            .frame(width: 80, height: 120)
                            .aspectRatio(contentMode: .fill)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }, placeholder: {
                        ProgressView()
                    })
                
        
                VStack(alignment: .leading) {
                    Text(vm.user.fullName)
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .padding(Spacing.eight)
                        .background(Capsule().fill(.white.opacity(0.4)))
                    
                    Text(vm.reformatJoinDate())
                        .font(.system(size: 11))
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Capsule().fill(.black.gradient))
                    
                    Spacer()
                    
                }
                Spacer()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12).fill(.purple.opacity(0.8).gradient))
            VStack {
                Spacer()
                Image(systemName: "airplane.departure")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 13))
                    .padding(8)
                    .background(Circle().fill(.black.gradient))
                
                Text("\(vm.user.trips?.count ?? 0)")
                    .fontWeight(.semibold)
                
                Image(systemName: "rectangle.3.group.fill")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 13))
                    .padding(8)
                    .background(Circle().fill(.black.gradient))
                
                Text("0")
                    .fontWeight(.semibold)
                
                Spacer()
                
            }
        }
   
    }
}

