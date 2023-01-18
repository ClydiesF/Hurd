//
//  HurdView.swift
//  Hurd
//
//  Created by clydies freeman on 1/16/23.
//

import SwiftUI

struct HurdView: View {
    @Binding var organizer: User?
    @Binding var members: [User]?
    @Binding var trip: Trip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top, spacing: 12) {
                if let organizer {
                    MemberProfilePreview(firstName: organizer.firstName, lastName: organizer.lastName, color: .bottleGreen, image: "mockAvatarImage", organizer: "Organizer")
                }
            
                Text((trip.tripDescription == "" ? "Organizer has not entered a description for this trip" : trip.tripDescription) ?? "")
                    .font(.system(size: 16))
            }
            
            HStack(spacing: -10) {
                
                if let members = self.members {
                    if !members.isEmpty {
                        ForEach(0..<4) { i in
                            if i == 3 && (members.count > 4) {
                                ZStack {
                                    Color.black
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                    
                                    Text("+\(members.count - 3)")
                                        .foregroundColor(.white)
                                        .fontWeight(.semibold)
                                }
                     
                            } else {
                                Image(members[i].profileImageUrl ?? "")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .clipShape(Circle())
                            }
                        }
                    }
   
                } else {
                    Text("No Members")
                        .font(.system(size: 15))
                }


                Spacer()
                
                Label("Add new member", systemImage: "plus")
                    .font(.system(size: 14))
                    .padding(8)
                    .background(Capsule().stroke(Color.gray.opacity(0.5)))
            }
        }
        .padding(.horizontal)
    }
}

struct HurdView_Previews: PreviewProvider {
    static var previews: some View {
        HurdView(organizer: .constant(User.mockUser1) , members: .constant([User.mockUser1,
                                                                            User.mockUser1,
                                                                            User.mockUser1,
                                                                            User.mockUser1,
                                                                            User.mockUser1,
                                                                            User.mockUser1,
                                                                            User.mockUser1]) , trip: .constant(Trip.mockTrip2))
    }
}
