//
//  TripDetailView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/23/23.
//

import SwiftUI

struct TripDetailView: View {
    @ObservedObject var vm: TripDetailViewModel
    @State var showTripSettingsView: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            AsyncImage(url: URL(string: vm.trip.tripImageURLString?.photoURL ?? ""), content: { image in
                ZStack {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    HStack {
                        VStack(alignment: .leading) {
                            Spacer()
                            Label(vm.trip.tripImageURLString?.authorName ?? "", systemImage: "camera.fill")
                                .font(.system(size: 13))
                                .fontWeight(.semibold)
                                .padding(10)
                                .background(
                                    Capsule().fill(.white.opacity(0.6)))
                        }
                        .padding(10)
                        
                        Spacer()
                    }
                
                }
                .frame(height: 200)

                
            }, placeholder: {
                ProgressView()
            })
            
            HStack {
                Spacer()
                Text(vm.trip.countDownTimerString)
                    .font(.system(size: 13))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                
                Label(vm.trip.tripType, systemImage: vm.trip.iconName)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .font(.system(size: 13))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.black))
                  
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(vm.trip.tripName)
                        .fontWeight(.bold)
                        .font(.system(size: 19))
                    
                    Label(vm.trip.tripDestination, systemImage: "location.fill")
                        .foregroundColor(.gray)
                        .font(.system(size: 13))
                }
                Spacer()
            }
            
            HStack {
                Text(vm.trip.dateRangeString)
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
                
                Spacer()
                
                Text("\(vm.trip.TripDuration) Days")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                    .font(.system(size: 13))
                    .padding(.vertical,5)
                    .padding(.horizontal,10)
                    .background(Capsule().fill(.black))
                
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    
                    Button {
                        vm.shouldShowBroadcastSheet = true
                    } label: {
                        Label("Broadcast", systemImage: "speaker.wave.2")
                            .tint(.black)
                            .font(.system(size: 14))
                            .frame(height:33)
                            .padding(.vertical, 5)
                            .padding(.horizontal, 10)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                    }.sheet(isPresented: $vm.shouldShowBroadcastSheet) {
                        BroadcastView()
                            .presentationDetents([.large])
                    }
                    
                    Label("Iteniarary", systemImage: "list.clipboard.fill")
                        .tint(.black)
                        .font(.system(size: 14))
                        .frame(height:33)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                    
                    
                    
                    NavigationLink {
                        TripNotesView(vm: vm)
                    } label: {
                        HStack {
                            Label("Notes", systemImage: "note.text")
                                .tint(.black)
                                .font(.system(size: 14))
                            if !(vm.notes?.isEmpty ?? true), let noteCount = vm.notes?.count {
                                Text("\(noteCount)")
                                    .font(.system(size: 13))
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white)
                                    .padding(5)
                                    .background(
                                        RoundedRectangle(cornerRadius: 5).fill(.black))
                            }
                        }
                        .frame(height:33)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                    }
              
                    Label("Components", systemImage: "menucard")
                        .tint(.black)
                        .font(.system(size: 14))
                        .frame(height:33)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                    
                    Label("Budget", systemImage: "dollarsign")
                        .tint(.black)
                        .font(.system(size: 14))
                        .frame(height:33)
                        .padding(5)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                }
                
            }
            
            Text("Overview")
                .font(.system(size: 17))
                .fontWeight(.bold)
            
            Text(vm.trip.tripDescription ?? "")
                .foregroundColor(.gray)
                .font(.system(size: 14))
            
      
                HurdPreviewView(hurd: vm.hurd)
            

            Spacer()
        }
        .padding(.horizontal, 16)
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
//                if let url = URL(string: generateBranchTripInviteLink() ?? "") {
//                    ShareLink(item: url) {
//                        Image(systemName: "square.and.arrow.up")
//                    }
//                }
                ShareLink(item: URL(string: "https://medium.com/macoclock/swiftui-flow-coordinator-pattern-with-navigationstack-to-coordinate-navigation-between-views-ios-1a2b6cd239d7")!) {
                    Image(systemName: "square.and.arrow.up")
                }
            }
            
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("setting screens")
                    showTripSettingsView = true
                    //router.navigate(to: .settings)
                    
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                }
            }
            
        }
        .navigationDestination(isPresented: $showTripSettingsView) {
            TripSettingsView(vm: .init(trip: vm.trip))
        }
        .onAppear {
           vm.fetchNotes()
        }
    }
}

struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TripDetailView(vm: TripDetailViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
