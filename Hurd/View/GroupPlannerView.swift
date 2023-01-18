//
//  GroupPlannerView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI
import SlidingTabView

struct GroupPlannerView: View {
    
    @ObservedObject var vm: GroupPlannerViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ZStack(alignment: .topTrailing) {
                    Image("mockbackground")
                        .resizable()
                        .frame(height: 170)
                        .ignoresSafeArea()
                        .overlay {
                            Color.black.opacity(0.1)
                        }
                    
                    Label(vm.timeRemaingTillTrip ?? "", systemImage: "clock")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                        .padding(5)
                        .background(Capsule().fill(Color.white))
                        .padding(.horizontal, 10)
                        .padding(.top, 10)
                }
                
                HStack(spacing: 15) {
                    
                    Label("Broadcast", systemImage: "speaker.wave.3.fill")
                        .font(.system(size: 14))
                        .padding(8)
                        .background(Capsule().stroke(Color.gray.opacity(0.5)))
                    
                    Label("Planner", systemImage: "list.bullet.clipboard.fill")
                        .font(.system(size: 14))
                        .padding(8)
                        .background(Capsule().stroke(Color.gray.opacity(0.5)))
                    
                    Label("Notes", systemImage: "note")
                        .font(.system(size: 14))
                        .padding(8)
                        .background(Capsule().stroke(Color.gray.opacity(0.5)))
                }
                .frame(height: 30)
                .padding(.leading, 10)
                
                Divider()
                //TRIP DETAIL VIEW
                TripDetailView(trip: $vm.trip)
                
                Divider()
                    .padding(.bottom, 10)
                
                HurdView(organizer: $vm.organizer, members: $vm.members, trip: $vm.trip)
                
                Divider()
                    .padding(.bottom, 10)
                
                HStack(spacing: 15) {
                    Button {
                        vm.presentTripCancellationSheet = true
                    } label: {
                        Label("Cancel Trip", systemImage: "xmark")
                            .foregroundColor(.red)
                            .font(.system(size: 14))
                            .padding(8)
                            .background(Capsule().stroke(Color.red))
                    }
                    
                    NavigationLink {
                        AddTripFormView(vm: returnPrepopulatedVM())
                    } label: {
                        Label("Edit Trip", systemImage: "pencil")
                            .font(.system(size: 14))
                            .padding(8)
                            .background(Capsule().stroke(Color.gray.opacity(0.5)))
                    }

              
                 
                    Label("Share Trip", systemImage: "square.and.arrow.up")
                        .font(.system(size: 14))
                        .padding(8)
                        .background(Capsule().stroke(Color.gray.opacity(0.5)))
                }
                .frame(height: 30)
                .padding(.leading, 10)
                
            }
            .onAppear{
                vm.fetchMembers()
            }
        }
        
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
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.large)
    }
    ///Func
    
    func returnPrepopulatedVM() -> AddTripFormViewModel {
        let vm = AddTripFormViewModel()
        vm.prepopulateValuesFrom(current: self.vm.trip)
        return vm
    }
}

struct GroupPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPlannerView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
