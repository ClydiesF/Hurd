//
//  TripSettingsView.swift
//  Hurd
//
//  Created by clydies freeman on 2/16/23.
//

import SwiftUI

struct TripSettingsView: View {
    @ObservedObject var vm: TripSettingsViewModel
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Button {
                        vm.presentTripCancellationSheet = true
                    } label: {
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                            .padding()
                        Text("Cancel Trip")
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .foregroundColor(.gray)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white).shadow(color: .gray.opacity(0.1), radius: 5, x: 3, y: 4))
                    .sheet(isPresented: $vm.presentTripCancellationSheet, content: {
                        VStack(alignment: .leading) {
                            Text("Are you sure?")
                                .font(.largeTitle)
                                .padding(.bottom, 10)
                            Text("Deleting this trip will remove this trip from everyone else in the Hurd as well.")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .padding(.bottom, 20)
                            
                            HStack {
                                Button("Keep Trip") {
                                    // Dismiss
                                    vm.presentTripCancellationSheet = false
                                }
                                Spacer()
                                Button("Cancel Trip") {
                                    // Dismiss
                                    vm.cancelTrip()
                                    vm.presentTripCancellationSheet = false
                                }
                            }
                        }
                        .padding(.horizontal)
                        .presentationDetents([.height(220)])
                        .presentationDragIndicator(.visible)
                    })
               
                VStack {
                    Button {
                        print("Show Edit Trip Screen")
                        vm.presentEditTripSheet = true
                        
                    } label: {
                        Image(systemName: "rectangle.and.pencil.and.ellipsis")
                            .font(.largeTitle)
                            .padding()
                        Text("Edit Trip")
                    }
                    
                }.frame(maxWidth: .infinity)
                    .padding()
                    .foregroundColor(.gray)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white).shadow(color: .gray.opacity(0.1), radius: 5, x: 3, y: 4))
                    .sheet(isPresented: $vm.presentEditTripSheet) {
                        AddTripFormView(vm: returnPrepopulatedVM())
                    }
 
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Trip Settings")
  
    }
    
    // Methods
    func returnPrepopulatedVM() -> AddTripFormViewModel {
        let vm = AddTripFormViewModel()
        vm.prepopulateValuesFrom(current: self.vm.trip)
        return vm
    }
}

struct TripSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TripSettingsView(vm: TripSettingsViewModel(trip: Trip.mockTrip))
    }
}
