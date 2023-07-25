//
//  HurdMemberView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/20/23.
//

import SwiftUI
import Kingfisher

struct HurdMemberView: View {
    
    var user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.eight) {
            HStack(spacing: Spacing.eight) {
                KFImage.url(URL(string: user.profileImageUrl ?? ""))
                              .loadDiskFileSynchronously()
                              .cacheMemoryOnly()
                              .fade(duration: 0.25)
                              .resizable()
                              .frame(width: 30,height: 30)
                              .clipShape(Circle())
                
                Text(user.firstName)
                    .fontWeight(.semibold)
                    .font(.system(size: 13))
                
            }
            
            Divider()
            Text(user.bio)
                .font(.system(size: 13))
                .foregroundColor(.gray)
            
            HStack {
                // Will use this later for achievements/ Roles in the hurd
                Text("🤖")
                    .font(.system(size: 13))
                Text("🤖")
                    .font(.system(size: 13))
                Text("🤖")
                    .font(.system(size: 13))
                Text("🤖")
                    .font(.system(size: 13))
                
                Spacer()

            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.3)))
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
           .contextMenu {
               Button("Remove from trip") {}
               Button("Add Permission") {}
           }
    
    }
    // Functions
    func removeFromTrip() {}
    func assign(permissions: [String], to userID: String) {}
}

struct HurdMemberView_Previews: PreviewProvider {
    static var previews: some View {
        HurdMemberView(user: User.mockUser2)
            .frame(width: 180)
            .padding()
    }
}
