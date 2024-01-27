//
//  ItineraryView.swift
//  HurdTravel
//
//  Created by clydies freeman on 1/26/24.
//

import SwiftUI

struct ItineraryView: View {
    @State var openActivityAddSheet: Bool = false
    @State var selectedSegment: Int = 0
    var pageContent = ["Blue","Red","Orange","Purple","Green"]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Trip Name")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button("Add Activity") {
                    openActivityAddSheet = true
                    print("DEBUG: add activity to trip!")
                }
            }
 
            ScrollView(.horizontal) {
                HStack(content: {
                    ForEach(0..<5) { index in
                        Text("MAY, Thu, 17")
                            .tag(index)
                            .padding(5)
                            .font(.system(size: 14))
                            .frame(height:33)
                            .background(RoundedRectangle(cornerRadius: 10).fill(selectedSegment == index ? .green :.gray.opacity(0.2)))
                            .onTapGesture {
                                selectedSegment = index
                            }
                    }
                })
            }
            Divider()
            
            // Enter Content HERE
            Text(pageContent[selectedSegment])
            
            Spacer()
        }
        .padding()
        .sheet(isPresented: $openActivityAddSheet, content: {
            Text("Hey this is going to be a form view as well. ")
                .padding(.horizontal)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        })
    }
}

#Preview {
    ItineraryView()
}
