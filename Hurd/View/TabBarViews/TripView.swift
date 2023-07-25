//
//  AddTripView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI
import Firebase
import os
import BranchSDK

struct TripView: View {
    
    @StateObject var vm = TripViewModel()
    @StateObject var addTripVM = AddTripFormViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
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
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .groupPlannerView(let trip, let hurd):
                    GroupPlannerView(vm:GroupPlannerViewModel(trip: trip, hurd: hurd))
                case .profile:
                    ProfileView(vm: ProfileViewModel(user: User.mockUser1))
                case .settings:
                    TripSettingsView(vm: TripSettingsViewModel(trip: Trip.mockTrip))
                    
                case .notes:
                    TripNotesView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
                }
            }
            .onOpenURL(perform: { url in
                // Need Both
                Branch.getInstance().handleDeepLink(url)
                Branch.getInstance().initSession(isReferrable: true) { (params, error) in
                    print("DEBUG: params String \(params as? [String: AnyObject] ?? [:])")
                    guard let paramDict = params as? [String: AnyObject] else { return }
                    
                    if paramDict["nav_to"] as? String == "groupPlannerView" {
                        guard let tripID = paramDict["tripID"], let hurdID = paramDict["hurdID"] else { return }
                        
                        print("DEBUG: trip \(tripID), hurd: \(hurdID)")
                        
                        let nc = NetworkCalls()
                        Task {
                            guard let trip = await nc.fetchTrip(with: tripID as! String),
                                  let hurd = await nc.fetchHurd(with: hurdID as! String) else { return }
                            
                            //path.append(.groupPlannerView(trip: trip, hurd: hurd))
                            router.navigate(to: .groupPlannerView(trip: trip, hurd: hurd))
                        }
                    }
                }
            })
            .onAppear {
                if vm.viewDidLoad == false {
                    vm.viewDidLoad = true
                    self.vm.getUser()
                    self.vm.subscribe()
                    
                }
            }
        }
    }
}

struct TripView_Previews: PreviewProvider {
    static var previews: some View {
        TripView(vm: TripViewModel())
    }
}
