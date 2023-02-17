//
//  TripNotesView.swift
//  Hurd
//
//  Created by clydies freeman on 1/17/23.
//

import SwiftUI

struct TripNotesView: View {
    @StateObject var vm: GroupPlannerViewModel
    @State var selection: Int = 0
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                HurdSlidingTabView(selection: $selection, tabs: ["Important","general"])
                    //.padding(.trailing, 130)
            }
           
            ForEach(vm.notes?.filter {$0.noteType == vm.noteTypes[selection]} ?? [], id: \.self) { note in
                NotesView(note: note , vm: vm)
            }
            Spacer()
        }
        .sheet(isPresented: $vm.showAddNoteForm, content: {
            AddNoteView(vm: vm)
        })
        .padding(.horizontal)
        .navigationTitle("Trip Notes")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    vm.showAddNoteForm = true
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Circle().fill(.black))
                }

            }
        }
        .onAppear {
            vm.fetchNotes()
        }
        //.animation(.easeInOut, value: vm.notes)
    }
}

struct TripNotesView_Previews: PreviewProvider {
    static var previews: some View {
        TripNotesView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
