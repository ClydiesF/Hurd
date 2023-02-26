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
        NavigationView {
            VStack {
                HurdSlidingTabView(selection: $vm.selection, tabs: ["Upcoming", "Past"], activeAccentColor: .black, selectionBarColor: .black)
                ScrollView {
                    switch vm.selection {
                    case 0:
                        if vm.trips.filter { ($0.tripEndDate + 86400) >= vm.currentDate }.isEmpty {
                            NoTripView(isPastTrip: $vm.isPastTrip)
                        } else {
                            ForEach(vm.trips.filter { ($0.tripEndDate + 86400) >= vm.currentDate }, id: \.id) { trip in
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
                    case 1:
                        if vm.trips.filter { ($0.tripEndDate + 86400) < vm.currentDate }.isEmpty {
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
                .sheet(isPresented: $addTripVM.addTripFormPresented) {
                    AddTripFormView(vm: addTripVM)
                }
                .navigationTitle("Your Trips")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            addTripVM.addTripFormPresented = true
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Circle().fill(.black))
                        }
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
