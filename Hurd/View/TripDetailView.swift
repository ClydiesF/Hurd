//
//  TripDetailView.swift
//  Hurd
//
//  Created by clydies freeman on 1/16/23.
//

import SwiftUI

struct TripDetailView: View {
    @Binding var trip: Trip
    
    var body: some View {
        VStack(alignment: .leading,spacing: 5) {
            Text(trip.tripName)
                .font(.system(size: 24))
                .fontWeight(.bold)
            
            Label(trip.tripDestination, systemImage: "location.fill")
                .font(.system(size: 14))
            Label(trip.dateRangeString, systemImage: "calendar")
                .font(.system(size: 14))
            Label(trip.tripCostString, systemImage: "dollarsign")
                .font(.system(size: 14))
            Label(trip.tripType, systemImage: trip.iconName)
                .font(.system(size: 14))
        }
        .padding(.horizontal)
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView(trip: .constant(Trip.mockTrip2))
    }
}
