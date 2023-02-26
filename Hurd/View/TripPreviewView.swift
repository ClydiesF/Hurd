//
//  TripPreviewView.swift
//  Hurd
//
//  Created by clydies freeman on 12/29/22.
//

import SwiftUI
import Kingfisher

struct TripPreviewView: View {
    
    @Binding var isPastTrip: Bool
    var trip: Trip
    var user: User?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack(alignment: .topTrailing) {
                
                //Image("mockbackground")
                KFImage(URL(string: trip.tripImageURLString?.photoURL ?? ""))
                    .resizable()
                    .frame(height: 220)
                    .frame(width: UIScreen.main.bounds.width * 0.9)
                    .scaledToFill()
                    .overlay {
                        Color("textColor").opacity(0.2)
                    }
                
                HStack(alignment: .top) {
                    if let user = user, let profileImage = user.profileImageUrl {
                        AsyncImage(url: URL(string: profileImage), content: { image in
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .background(Circle().stroke(Color("backgroundColor"), lineWidth: 5))
                                .padding()
                        }) {
                            Circle()
                                .fill(.gray)
                                .frame(width: 60, height: 60)
                                .padding()
      
                        }
                        
                    } else {
                        Circle()
                            .fill(.gray)
                            .frame(width: 60, height: 60)
                            .background(Circle().stroke(Color("textColor"), lineWidth: 8))
                            .padding()
                    }
                    
                    Spacer()
                    VStack(alignment: .trailing,spacing: 10) {
                        HStack {
                            TripDateView(tripDate: trip.tripStartDate)
                            
                            TripDateView(tripDate: trip.tripEndDate)
                        }
                      
                     
                        Spacer()
                        
                        Image(systemName: trip.iconName)
                            .foregroundColor(Color("backgroundColor"))
                            .padding()
                            .background(Circle().fill(Color("textColor")))
                    }
                    .padding()
                }
     
            }
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(height: 220)
            .frame(width: UIScreen.main.bounds.width * 0.9)
            
            Text(trip.tripName)
                .font(.system(size: 25))
                .foregroundColor(Color("textColor"))
                .fontWeight(.bold)
            
            Label(trip.tripDestination, systemImage: "mappin")
                .foregroundColor(.gray)
            
        }
        .grayscale(isPastTrip ? 1 : 0)

    }
}

struct TripPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        TripPreviewView(isPastTrip: .constant(true), trip: Trip.mockTrip2)
            .padding()
    }
}
