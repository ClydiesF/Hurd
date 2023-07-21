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
        VStack(alignment: .leading, spacing: Spacing.eight) {
            // Trip Image VStack
            VStack(spacing: Spacing.eight) {
                HStack(alignment: .top) {
                    if let user = user, let profileImage = user.profileImageUrl {
                        AsyncImage(url: URL(string: profileImage), content: { image in
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                                .background(Circle().stroke(Color.white, lineWidth: 5))
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
                            .frame(width: 40, height: 40)
                            .background(Circle().stroke(Color.white, lineWidth: 3))
                            .padding()
                    }

                    Spacer()
                    VStack(alignment: .trailing,spacing: 10) {
                        HStack {
                            TripDateView(tripDate: trip.tripStartDate)

                            TripDateView(tripDate: trip.tripEndDate)
                        }


                        Spacer()
                        HStack {
                            TripInfoBlock(value: trip.TripDuration, title: "Days", showBorder: false)
                            TripInfoBlock(value: "1", title: "Herd", showBorder: false)
                            Image(systemName: trip.iconName)
                                .foregroundColor(Color("backgroundColor"))
                                .padding()
                                .background(Circle().fill(Color("textColor").gradient))
                        }
                  
                    }
                    .padding()
                }
            }
            .frame(height: 160)
            .background(
                AsyncImage(url: URL(string: trip.tripImageURLString?.photoURL ?? "")) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .overlay {
                                Color("textColor").opacity(0.2)
                            }

                    } else if phase.error != nil { // 3
                        // some kind of error appears
                        Text("No image available")
                    } else {
                        //appears as placeholder image
                        Image("mockbackground") // 4
                     
                    }
                }
            ).clipShape(RoundedRectangle(cornerRadius: 10))

            // Trip Info Stack
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Label(trip.tripDestination, image: "locationPin")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    Text(trip.tripName)
                        .font(.system(size: 18))
                        .foregroundColor(Color("textColor"))
                        .fontWeight(.bold)
                }
                Spacer()
                HStack(alignment: .top, spacing: 10) {
                    if let _ = trip.countdownPercentage, let cdays = trip.countDownTimer["days"], cdays != 0  {
                        Text("\(14)D : \(11)H")
                            .font(.system(size: 13))
                            .fontWeight(.semibold)
                            .padding(Spacing.eight)
                            .background(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                            .background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
                    }
                }
            }
            
        }
        .grayscale(isPastTrip ? 1 : 0)

    }
}

struct TripPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TripPreviewView(isPastTrip: .constant(false), trip: Trip.mockTrip2)
                .padding()
            
            TripPreviewView(isPastTrip: .constant(true), trip: Trip.mockTrip2)
                .padding()
        }
    }
}

struct TripInfoBlock: View {
    
    let value: String
    let title: String
    var showBorder: Bool = true
    
    var body: some View {
        HStack {
            Text(value)
                .fontWeight(.semibold)
                .font(.system(size: 12))
                .foregroundColor(Color("textColor"))
            Text(title)
                .font(.system(size: 12))
                .foregroundColor(Color("textColor"))
        }
        .padding(5)
        .background(Capsule().stroke( showBorder ? .gray : .clear, lineWidth: 1))
        .background(Capsule().fill(.white))
    }
}
