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
        ZStack(alignment: .topTrailing) {
            Button {
                //code to post code to trips database\
                print("post a trip to user, profile")
                switch vm.formType {
                case .edit:
                    vm.editTrip()
                case .add:
                    vm.postTrip()
                }
                vm.addTripFormPresented = false
            } label: {
                ZStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "signpost.left.fill")
                            .foregroundColor(.white)
                     
                        
                        Text(vm.formType == .edit ? "Save Changes":"Post Trip")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(.trailing)
                    }
                    .padding(10)
                    .background(Capsule().fill(Color.bottleGreen))// turn green after validation
                }
            }
            .padding(.trailing)
            .zIndex(99)

            Form {
                
                Text(vm.formType == .edit ? "Edit Trip": "Add Trip")
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                TextField("Trip Name", text: $vm.tripNameText)
                
                ZStack(alignment: .trailing) {
                    TextField("Trip Location", text: $vm.tripLocationSearchQuery)
                    if vm.status == .isSearching {
                        Image(systemName: "clock")
                            .foregroundColor(.gray)
                    }
                    
                }
                if vm.status == .result && !vm.searchResults.isEmpty {
                    List {
                        ForEach(vm.searchResults, id: \.self) { resultItem in
                            
                            Button {
                                vm.selectedLocation()
                                vm.tripLocationSearchQuery = "\(resultItem.title), \(resultItem.subtitle)"
                                
                                // make a call to grab lat and long, based off title and subtitle of resul Item Object
                                
                            } label: {
                                Text("\(resultItem.title), \(resultItem.subtitle)")
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
                
                
            }
            .padding(.top, Spacing.twentyone)
        }
        .padding(.top)
     
    }
}

struct AddTripFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTripFormView(vm: AddTripFormViewModel())
    }
}
