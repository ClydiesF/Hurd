//
//  TripPreviewView.swift
//  Hurd
//
//  Created by clydies freeman on 12/29/22.
//

import SwiftUI

struct TripPreviewView: View {
    
    @Binding var isPastTrip: Bool
    
    let trip: Trip
    var user: User?
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .bottomTrailing) {
                Image("mockbackground")
                    .resizable()
                    .frame(height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .grayscale(isPastTrip ? 1 : 0)
                
                Image(systemName: trip.iconName)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(
                        Color.black
                    )
                    .clipShape(Circle())
                    .padding()
            }

       
            // TRIP Image
            
            HStack {
                if let user = user, let profileImage = user.profileImageUrl {
                    AsyncImage(url: URL(string: profileImage), content: { image in
                        image
                            .resizable()
                            .frame(width: 30, height: 30)
                            .cornerRadius(15)
                    }) {
                        Circle()
                            .frame(width: 30, height: 30)
                            .cornerRadius(15)
                        
                    }
                    
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 30, height: 30)
                        .cornerRadius(15)
                }
                
                Text(trip.tripName)
                    .foregroundColor(.black)
                    .font(.title3)
                    .fontWeight(.heavy)
                
                Spacer()
            }
            
            
            HStack {
                Group {
                    Label(trip.tripDestination, systemImage: "location.fill")
                    Divider()
                    Label(trip.dateRangeString, systemImage: "calendar")
                }
                .foregroundColor(.black)
                .font(.system(size: 14))
        
            }
            .frame(height: 15)
            
            Spacer()
        }
    }
}

//struct TripPreviewView_Previews: PreviewProvider {
//    static var previews: some View {
//        TripPreviewView(isPastTrip: true, trip: Trip.mockTrip2)
//            .padding()
//    }
//}
