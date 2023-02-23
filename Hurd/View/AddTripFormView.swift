//
//  AddTripFormView.swift
//  Hurd
//
//  Created by clydies freeman on 1/11/23.
//
import SwiftUI

struct AddTripFormView: View {
    @ObservedObject var vm: AddTripFormViewModel
    
    var body: some View {
        Form {
            Section(vm.formType == .edit ? "Edit Trip": "Add Trip") {
                TextField("Trip Name", text: $vm.tripNameText)
            }
            .padding(.top, Spacing.sixteen)
            
            Section("Trip Location") {
                ZStack(alignment: .trailing) {
                    TextField("Trip Location", text: $vm.tripLocationSearchQuery)
                    if vm.locationStatus != .selected {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                    }
                    
                }
                
                if vm.locationStatus != .selected {
                    List {
                        ForEach(vm.searchResults, id: \.self) { resultItem in
                            Button {
                                vm.selectedLocation(resultItem)
                                // make a call to grab lat and long, based off title and subtitle of resul Item Object
                            } label: {
                                Text("\(resultItem.title), \(resultItem.subtitle)")
                            }
                        }
                    }
                }
            }
            
            // Trip Type
            Picker("Chose a trip type", selection: $vm.selectedTripType) {
                ForEach(vm.tripTypes, id: \.self) {
                    Text($0)
                }
            }
            
            // Cost Estimate
            Section {
                Slider(value: $vm.tripCostEstimate, in: 0...5000)
                    .tint(.bottleGreen)
                Text("$\(vm.tripCostEstimate, specifier: "%.1f") Per Person")
            } header: {
                Text("Trip Cost Estimate")
            }
            
            // Dates
            Section {
                DatePicker(selection: $vm.tripStartDate, in: Date.now..., displayedComponents: .date) {
                    Text("Trip Start")
                }
                
                DatePicker(selection: $vm.tripEndDate, in: vm.tripStartDate..., displayedComponents: .date) {
                    Text("Trip End")
                }
            } header: {
                Text("Trip Dates")
            }
            
            // Description
            Section {
                TextEditor(text: $vm.tripDescriptionText)
            } header: {
                Text("Tell us about why this trip will be cool")
            }
            
            
            // button to add Trip
            Button {
                if vm.fieldsArePopulated {
                    //code to post code to trips database\
                    print("post a trip to user, profile")
                    switch vm.formType {
                    case .edit:
                        vm.editTrip()
                    case .add:
                        Task {
                            await vm.postTrip()
                        }
                    }
                    vm.addTripFormPresented = false
                }
            } label: {
                ZStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "signpost.left.fill")
                            .foregroundColor(.gray)
                        
                        
                        Text(vm.formType == .edit ? "Save Changes":"Post Trip")
                            .fontWeight(.semibold)
                            .padding(.trailing)
                    }
                    .padding(10)
                }
            }
            .disabled(!vm.fieldsArePopulated)
        }

    }
}


struct AddTripFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTripFormView(vm: AddTripFormViewModel())
    }
}
