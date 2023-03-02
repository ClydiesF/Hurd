//
//  NoTripView.swift
//  Hurd
//
//  Created by clydies freeman on 2/26/23.
//

import SwiftUI

struct NoTripView: View {
    @Binding var isPastTrip: Bool
    
    let noCurrentTripMsg = "Add a Trip or have a friend invite you to a trip to see it here!"
    let noPastTripMsg = "You dont have any Currently completed or trips in the past"
    
    var body: some View {
        VStack {
            Text("No Trips")
                .font(.largeTitle)
                .foregroundColor(.black)
                .bold()
                .padding(.bottom, Spacing.sixteen)
            
            Text(isPastTrip ? noPastTripMsg : noCurrentTripMsg)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(.white).shadow(color: .gray.opacity(0.2), radius: 5, x: 5, y: 5))
        .padding()
    }
}

struct NoTripView_Previews: PreviewProvider {
    static var previews: some View {
        NoTripView(isPastTrip: .constant(true))
            
    }
}
