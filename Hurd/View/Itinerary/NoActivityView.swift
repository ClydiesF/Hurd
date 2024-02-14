//
//  NoActivityView.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/13/24.
//

import SwiftUI

struct NoActivityView: View {
    
    @Binding var shouldShowAlert: Bool
    @Binding var type: ActivityFormType
    @Binding var swappedActivity: Activity?
    
    var body: some View {
        VStack(spacing: Spacing.eight) {
            Text("No Activities")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Spice up the day, and add some fun activities to do today!")
                .foregroundStyle(.gray.opacity(0.8))
                .multilineTextAlignment(.center)
            
            Button(action: {
                type = .add
                swappedActivity = nil
                shouldShowAlert = true
            }, label: {
                Text("Add Activity")
            })
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15).fill(.white))
        .shadow(color: .gray.opacity(0.3) ,radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

    }
}

#Preview {
    NoActivityView(shouldShowAlert: .constant(true), type: .constant(.add), swappedActivity: .constant(Activity.mockActivity))
}
