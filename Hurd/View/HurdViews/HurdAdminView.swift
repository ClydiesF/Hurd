//
//  HurdAdminView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/20/23.
//

import SwiftUI
import Kingfisher

struct HurdAdminView: View {
    
    let user: User
    
    var body: some View {
        HStack(alignment: .top, spacing: Spacing.eight) {
            VStack {
                KFImage.url(URL(string: user.profileImageUrl ?? ""))
                              .loadDiskFileSynchronously()
                              .cacheMemoryOnly()
                              .fade(duration: 0.25)
                              .resizable()
                              .frame(width: 30,height: 30)
                              .clipShape(Circle())
                //Spacer()
                // Use this for  admine role. 
                
            }
            
            VStack(alignment: .leading, spacing: Spacing.eight) {
                Text(user.firstName)
                    .fontWeight(.semibold)
                    .font(.system(size: 13))
                
                Text(user.bio)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            Spacer()
            
            VStack(spacing: Spacing.eight) {
                VStack {
                    Image(systemName: "star.fill")
                        .font(.system(size: 14))
                    // Coming soon Feature
                    Text("0")
                        .font(.system(size: 14))
                }
                VStack {
                    Image(systemName: "bubble.left.fill")
                        .font(.system(size: 14))
                    // Coming soon Feature
                    Text("0")
                        .font(.system(size: 14))
                }
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
        }
        .frame(maxWidth: .infinity)
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
    }
}

struct HurdAdminView_Previews: PreviewProvider {
    static var previews: some View {
        HurdAdminView(user: User.mockUser4)
    }
}
