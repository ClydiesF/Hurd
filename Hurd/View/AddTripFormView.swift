//
//  AddTripFormView.swift
//  Hurd
//
//  Created by clydies freeman on 1/11/23.
//
import SwiftUI

struct AddTripFormView: View {
    @StateObject var vm = AddTripFormViewModel()
    
    var body: some View {
        VStack(alignment: .trailing) {
            Button {
                //code to post code to user's PRofile
                print("post a trip to user, profile")
            } label: {
                ZStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "signpost.left.fill")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(Color.black.opacity(0.4))
                            .clipShape(Circle())
                        
                        Text("Post Trip")
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding(.trailing)
                    }
                    .padding(8)
                    .background(Capsule().fill(Color.gray))// turn green after validation
                }
            }
            .padding(.trailing)

            Form {
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
        }
     
    }
}

struct AddTripFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTripFormView()
    }
}
