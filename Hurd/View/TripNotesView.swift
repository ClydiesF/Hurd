//
//  TripNotesView.swift
//  Hurd
//
//  Created by clydies freeman on 1/17/23.
//

import SwiftUI

struct TripNotesView: View {
    
    @State var selection: Int = 0
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                HurdSlidingTabView(selection: $selection, tabs: ["Important","general"])
                    //.padding(.trailing, 130)
                Button {
                    // toogle for full screen
                    
                } label: {
                    Label("Add Note", systemImage: "note.text")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding(8)
                        .background(Capsule().fill(Color.bottleGreen))
                }
        

            }
           
            ForEach(0..<3) { _ in
                NotesView()
            }
            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle("Trip Notes")
    }
}

struct TripNotesView_Previews: PreviewProvider {
    static var previews: some View {
        TripNotesView()
    }
}
