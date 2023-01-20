//
//  TripNotesView.swift
//  Hurd
//
//  Created by clydies freeman on 1/17/23.
//

import SwiftUI

struct TripNotesView: View {
    @ObservedObject var vm: GroupPlannerViewModel
    @State var selection: Int = 0
    @State var showAddNoteForm: Bool = false
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                HurdSlidingTabView(selection: $selection, tabs: ["Important","general"])
                    //.padding(.trailing, 130)
                
                Button {
                    // toogle for full screen
                    showAddNoteForm = true
                    
                } label: {
                    Label("Add Note", systemImage: "note.text")
                        .foregroundColor(.white)
                        .font(.system(size: 14))
                        .padding(8)
                        .background(Capsule().fill(Color.bottleGreen))
                }
            }
           
            ForEach(vm.notes?.filter {$0.noteType == vm.noteTypes[selection]} ?? [], id: \.self) { note in
                NotesView(note: note)
            }
            Spacer()
        }
        .sheet(isPresented: $showAddNoteForm, content: {
            AddNoteView(vm: vm)
        })
        .padding(.horizontal)
        .navigationTitle("Trip Notes")
        .onAppear {
            vm.fetchNotes()
        }
    }
}

struct TripNotesView_Previews: PreviewProvider {
    static var previews: some View {
        TripNotesView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
