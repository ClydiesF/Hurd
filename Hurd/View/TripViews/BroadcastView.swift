//
//  BroadcastView.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/11/23.
//

import SwiftUI
import FirebaseMessaging

struct BroadcastView: View {
    @State var title: String = ""
    @State var message: String = ""
    
    var body: some View {
        VStack(spacing: Spacing.sixteen) {
            Text("📣 Broadcast ")
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Write a short message to update your friends on any details of your trip")
                .font(.system(size: 13))
                .foregroundColor(.gray)
            
            TextField("Title", text: $title)
                .textFieldStyle(.roundedBorder)
            
            TextField("What do you want to tell the members", text: $message)
                .textFieldStyle(.roundedBorder)
            
            Button("Send") {
                print("Send out the broadcast")
            }
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: Methods

}

struct BroadcastView_Previews: PreviewProvider {
    static var previews: some View {
        BroadcastView()
    }
}
