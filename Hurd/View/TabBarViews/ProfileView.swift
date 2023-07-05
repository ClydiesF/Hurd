//
//  ProfileView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @State private var selectedTabIndex = 0
    @ObservedObject var vm: ProfileViewModel
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                ZStack {
                    Rectangle()
                        .fill(Color.bottleGreen.gradient)
                        .ignoresSafeArea()

                    VStack {
                        Spacer()

                        KFImage(URL(string: vm.profilePicture))
                            .resizable()
                            .frame(width: 130, height: 130)
                            .clipShape(Circle())

                        Text("\(vm.firstName) \(vm.lastName)")
                            .font(.system(size: 25))
                            .foregroundColor(.white)
                            .fontWeight(.semibold)

                        Text(reformatJoinDate())
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
                        
                        if vm.phoneNumber != "" {
                            Label(vm.phoneNumber, systemImage: "phone.fill")
                                .font(.system(size: 14))
                        }
                        
                        Label("Boston, MA", systemImage: "location.fill")
                            .font(.system(size: 14))
                        
                        if let email = vm.user.emailAddress {
                            Label(email, systemImage: "envelope.fill")
                                .font(.system(size: 14))
                                .tint(.black)
                        }
                        
                        if vm.gender != "" {
                            Text(vm.gender)
                                .font(.system(size: 14))
                        }
              
                        if vm.ethnicity != "" {
                            Text(vm.ethnicity)
                                .font(.system(size: 14))
                        }
                 
                    }
                    Spacer()
                }
                .padding(.horizontal, Spacing.twentyone)
     
                if vm.bio != "" {
                    Text(vm.bio)
                        .font(.system(size: 14))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.horizontal, Spacing.twentyone)
                }

        
      
                Spacer()
            }
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
    func reformatJoinDate() -> String {
        guard let joinDate = vm.user.createdAt else { return "" }
        let ts = Date(timeIntervalSince1970: joinDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM d, yyyy" //Specify your format that you want
        let timestamp = dateFormatter.string(from: ts)
        
        
        return "Joined \(timestamp)"
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(vm: ProfileViewModel(user: User.mockUser1))
    }
}
