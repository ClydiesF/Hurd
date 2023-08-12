//
//  AddTripFormView.swift
//  Hurd
//
//  Created by clydies freeman on 1/11/23.
//
import SwiftUI

struct AddTripFormView: View {
    @ObservedObject var vm: AddTripFormViewModel
    @FocusState private var focusedField: Field?
    
    enum Field {
        case tripName
        case tripLocation
        case tripType
        case tripCost
        case tripStart
        case tripEnd
        case tripDescription
    }
    
    var body: some View {
        Form {
            Section(vm.formType == .edit ? "Edit Trip": "Add Trip") {
                TextField("Trip Name", text: $vm.tripNameText)
                    .focused($focusedField, equals: .tripName)
                    .submitLabel(.next)
                
                Picker("Hurd", selection: $vm.selectedTripType) {
                    ForEach(vm.tripTypes, id: \.self) {
                        Text($0)
                    }
                }
            }
            
            Section("Trip Location") {
                ZStack(alignment: .trailing) {
                    TextField("Trip Location", text: $vm.tripLocationSearchQuery)
                        .focused($focusedField, equals: .tripLocation)
                        .submitLabel(.next)
                    
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
            .focused($focusedField, equals: .tripType)
            .submitLabel(.next)
            
  
            // Dates
            Section {
                DatePicker(selection: $vm.tripStartDate, in: Date.now..., displayedComponents: .date) {
                    Text("Trip Start")
                }
                .focused($focusedField, equals: .tripStart)
                .submitLabel(.next)
                
                DatePicker(selection: $vm.tripEndDate, in: vm.tripStartDate..., displayedComponents: .date) {
                    Text("Trip End")
                }
                .focused($focusedField, equals: .tripEnd)
                .submitLabel(.next)
                
                
            } header: {
                Text("Trip Dates")
            }
            
            // Description
            Section {
                TextEditor(text: $vm.tripDescriptionText)
                    .focused($focusedField, equals: .tripDescription)
                    .submitLabel(.next)
            } header: {
                Text("Tell us about why this trip will be cool")
            }
            
            
            // button to add Trip
            Button(vm.formType == .edit ? "Save Changes" : "Post Trip") {
                if vm.fieldsArePopulated {
                    //code to post code to trips database\
                    print("post a trip to user, profile")
                    switch vm.formType {
                    case .edit:
                        Task {
                            await vm.editTrip()
                        }
                    case .add:
                        Task {
                            await vm.postTrip()
                        }
                    }
                    vm.addTripFormPresented = false
                }
            }
            .disabled(!vm.fieldsArePopulated)
        }
        .onSubmit {
            switch focusedField {
            case .tripName:
                focusedField = .tripLocation
            case .tripLocation:
                focusedField = .tripType
            case .tripType:
                focusedField = .tripCost
            case .tripCost:
                focusedField = .tripStart
            case .tripStart:
                focusedField = .tripEnd
            case .tripEnd:
                focusedField = .tripDescription
            default:
                print("Submiting Trip")
            }
        }
        .onTapGesture(count: 2) {
            hideKeyboard()
        }

    }
}


struct AddTripFormView_Previews: PreviewProvider {
    static var previews: some View {
        AddTripFormView(vm: AddTripFormViewModel())
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

//
// Cost Estimate
//Section {
//    Slider(value: $vm.tripCostEstimate, in: 0...5000)
//        .tint(.bottleGreen)
//        .focused($focusedField, equals: .tripCost)
//        .submitLabel(.next)
//    Text("$\(vm.tripCostEstimate, specifier: "%.1f") Per Person")
//} header: {
//    Text("Trip Cost Estimate")
//}

