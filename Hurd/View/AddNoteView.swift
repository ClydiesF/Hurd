//
//  AddNoteView.swift
//  Hurd
//
//  Created by clydies freeman on 1/19/23.
//

import SwiftUI

struct AddNoteView: View {
    
    @ObservedObject var vm: GroupPlannerViewModel
    
    var body: some View {
        Form {
            
            Section("Title") {
                TextField("Add Title", text: $vm.title)
            }
            
            
            Section("Note Type") {
                Picker("Choose a note Type", selection: $vm.noteType ) {
                    ForEach(vm.noteTypes, id: \.self) { nteType in
                        Text(nteType)
                    }
                }
            }
            
            Section {
                TextEditor(text: $vm.bodyText)
            } header: {
                Text("Enter the body of the text")
            }
            
            Button {
                vm.addNote()
            } label: {
                Text("Add Note")
            }
        }
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
