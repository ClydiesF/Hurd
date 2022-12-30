//
//  TripPreviewView.swift
//  Hurd
//
//  Created by clydies freeman on 12/29/22.
//

import SwiftUI

struct TripPreviewView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("mockAvatarImage")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .cornerRadius(15)
                
                Text("Weekend Getaway")
                    .foregroundColor(.corn)
                    .font(.title3)
                    .fontWeight(.heavy)
                
                Spacer()
            }
            
            HStack {
                TagView(tagName: "9 Days Left")
                TagView(tagName: "Wakikki Springs")
                TagView(tagName: "1/2/22-1/9/22")
            }
            
            Spacer()
            
            HStack {
                TagView(tagName: "Upcoming")
                TagView(tagName: "Excursion")
            }
        }
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .padding()
        .background(
            Image("mockbackground")
                .resizable()
                .overlay(content: {
                    Color.black.opacity(0.2)
                })
        )
        .cornerRadius(10)
    }
}

struct TripPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        TripPreviewView()
            .padding()
    }
}
