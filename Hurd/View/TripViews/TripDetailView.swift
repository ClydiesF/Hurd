//
//  TripDetailView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/23/23.
//

import SwiftUI

struct TripDetailView: View {
    var body: some View {
        
            VStack(alignment: .leading) {
                
                HStack {
                    Spacer()
                    Text("Vacation")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .font(.system(size: 13))
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.black))
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Miami Vice Trip")
                            .fontWeight(.bold)
                            .font(.system(size: 17))
                        Text("12 Miami Dade County,FL, USA")
                            .font(.system(size: 13))
                    }
                    Spacer()
                    
                    Text("55d:44h:44m")
                        .font(.system(size: 13))
                        .padding(10)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                }
                
                HStack {
                    Text(Date(), style: .date)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                    
                    Text("-")
                    
                    Text(Date(), style: .date)
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                    
                    Spacer()
                    
                    Text("3 Days")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .font(.system(size: 13))
                        .padding(.vertical,5)
                        .padding(.horizontal,10)
                        .background(Capsule().fill(.black))
                    
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Label("Broadcast", systemImage: "speaker.wave.2")
                            .font(.system(size: 13))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                        Label("Iteniarary", systemImage: "list.clipboard.fill")
                            .font(.system(size: 13))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                        Label("Notes", systemImage: "note.text")
                            .font(.system(size: 13))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                        Label("Components", systemImage: "menucard")
                            .font(.system(size: 13))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                        
                        Label("Budget", systemImage: "dollarsign")
                            .font(.system(size: 13))
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                    }
                    
                }
              
                Text("Overview")
                    .font(.system(size: 17))
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text("This trip is a very good trio and i thnkn that if we gather everyone this will be super coola nd i reslly like this trip. were going to do a bunch of trips and so all this cool stuff. i thiink that we should do tal this ,i know right.")
                    .foregroundColor(.gray)
                    .font(.system(size: 14))
                
                HurdPreviewView()
            }

    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView()
            .padding()
    }
}
