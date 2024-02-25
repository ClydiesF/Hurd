//
//  TripNotesView.swift
//  Hurd
//
//  Created by clydies freeman on 1/17/23.
//

import SwiftUI
import Firebase

struct TripNotesView: View {
    @ObservedObject var vm: TripDetailViewModel
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State var selection: Int = 0
    
    var body: some View {
        VStack(spacing: 10) {
            HStack(spacing: 20) {
                HurdSlidingTabView(selection: $selection, tabs: ["All", "Yours", "Others"], activeAccentColor: Color("textColor"), selectionBarColor: Color("textColor"))
                    //.padding(.trailing, 130)
            }
            LazyVGrid(columns: columns) {
                switch selection {
                case 0:
                    ForEach(vm.notes ?? [], id: \.self) { note in
                        NotesView(note: note , vm: vm)
                    }
                case 1:
                    ForEach(vm.notes?.filter { $0.authorID == Auth.auth().currentUser?.uid } ?? [], id: \.self) { note in
                        NotesView(note: note , vm: vm)
                    }
                default:
                    ForEach(vm.notes?.filter { $0.authorID != Auth.auth().currentUser?.uid } ?? [], id: \.self) { note in
                        NotesView(note: note , vm: vm)
                    }
                    
                }
         
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
                        .foregroundColor(Color("backgroundColor"))
                        .padding(5)
                        .background(Circle().fill(Color("textColor").gradient))
                }

            }
        }
        .onAppear {
            // REMOVE THIS TO GET PREVIEW TO WORK
          //vm.fetchNotes()
        }
        .animation(.easeInOut, value: selection)
    }
}

struct TripNotesView_Previews: PreviewProvider {
    static var previews: some View {
        TripNotesView(vm: TripDetailViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
