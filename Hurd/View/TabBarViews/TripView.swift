//
//  AddTripView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI
import Firebase
import os

struct TripView: View {
    
    @StateObject var vm = TripViewModel()
    @StateObject var addTripVM = AddTripFormViewModel()
    
    var body: some View {
            VStack {
                HurdSlidingTabView(selection: $vm.selection, tabs: ["Upcoming", "Past"], activeAccentColor: Color("textColor"), selectionBarColor: Color("textColor"))
                ScrollView {
                    switch vm.selection {
                    case 0: // Upcoming Trips
                        if vm.trips.filter({ ($0.tripEndDate + 86400) >= vm.currentDate }).isEmpty {
                            NoTripView(isPastTrip: $vm.isPastTrip)
                        } else {
                            ForEach(vm.trips.filter { ($0.tripEndDate + 86400) >= vm.currentDate }, id: \.id) { trip in
                                if let hurd = trip.hurd {
                                    NavigationLink {
                                        GroupPlannerView(vm: GroupPlannerViewModel(trip: trip, hurd: hurd))
                                    } label: {
                                        TripPreviewView(isPastTrip: $vm.isPastTrip, trip: trip, user: vm.user)
                                            .padding(.horizontal)
                                            .padding(.bottom, 10)
                                    }
                                }
                        
                            }
                        }
                    case 1: // Past Trip
                        if vm.trips.filter({ ($0.tripEndDate + 86400) < vm.currentDate }).isEmpty {
                            NoTripView(isPastTrip: $vm.isPastTrip)
                        } else {
                            ForEach(vm.trips.filter { ($0.tripEndDate + 86400) < vm.currentDate }, id: \.id) { trip in
                                if let hurd = trip.hurd {
                                    NavigationLink(destination: {
                                        GroupPlannerView(vm: GroupPlannerViewModel(trip: trip, hurd: hurd))
                                    }, label: {
                                        TripPreviewView(isPastTrip: $vm.isPastTrip, trip: trip, user: vm.user)
                                            .padding(.horizontal)
                                            .padding(.bottom, 10)
                                    })
                                }
                        
                            }
                        }
                    default:
                        EmptyView()
                    }
                           
                    
                }
                .sheet(isPresented: $addTripVM.addTripFormPresented, onDismiss: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        addTripVM.resetFormValues()
                    }
                }, content: {
                    AddTripFormView(vm: addTripVM)
                })
                .navigationTitle("Your Trips")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addTripVM.addTripFormPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(Color("backgroundColor"))
                                .padding(5)
                                .background(Circle().fill(Color("textColor").gradient))
                        }
                    }
                }
            }
        .onAppear {
            if vm.viewDidLoad == false {
                vm.viewDidLoad = true
                self.vm.getUser()
                self.vm.subscribe()
                
            }
        }
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(vm: TripViewModel())
    }
}
