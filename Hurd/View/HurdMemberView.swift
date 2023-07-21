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
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
    
    }
}

struct HurdMemberView_Previews: PreviewProvider {
    static var previews: some View {
        HurdMemberView(user: User.mockUser1)
            .frame(width: 170)
            .padding()
    }
}
