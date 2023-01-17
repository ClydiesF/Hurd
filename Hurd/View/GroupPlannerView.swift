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
                    
                    Label("5W 4D", systemImage: "clock")
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
                
                HurdView(organizer: $vm.organizer, members: $vm.members, tripDescription: vm.trip.tripDescription)
                
                Divider()
                    .padding(.bottom, 10)
                
                HStack(spacing: 15) {
                    
                    Label("Cancel Trip", systemImage: "xmark")
                        .foregroundColor(.red)
                        .font(.system(size: 14))
                        .padding(8)
                        .background(Capsule().stroke(Color.red))
                    
                    Label("Edit Trip", systemImage: "pencil")
                        .font(.system(size: 14))
                        .padding(8)
                        .background(Capsule().stroke(Color.gray.opacity(0.5)))
                 
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
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct GroupPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPlannerView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
