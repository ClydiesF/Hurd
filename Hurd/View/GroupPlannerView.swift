//
//  GroupPlannerView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI
import SlidingTabView
import Kingfisher
import CoreLocation
import MapKit
import Alamofire

struct GroupPlannerView: View {
    
    @ObservedObject var vm: GroupPlannerViewModel
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    KFImage(URL(string: vm.trip.tripImageURLString?.photoURL ?? ""))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 350)
                        .frame(height: 340)
                        .overlay {
                            Color("textColor").opacity(0.2)
                        }
                    
                    HStack(alignment: .bottom) {
                        if let authorName = vm.trip.tripImageURLString?.authorName {
                            Label(authorName, systemImage: "camera.fill")
                                .foregroundColor(.white)
                        }

                        Spacer()
                        
                        VStack(alignment: .trailing,spacing: 0) {
                            TripDateView(tripDate: vm.trip.tripStartDate)
                                .padding(.bottom,10)
                            
                            TripDateView(tripDate: vm.trip.tripEndDate)
                                .padding(.bottom,10)
                            
                            Image(systemName: "car.fill")
                                .foregroundColor(Color("backgroundColor"))
                                .padding()
                                .background(Circle().fill(Color("textColor").gradient))
                            
                            Spacer()
                        }
                    }
                    .padding()
                }
                .frame(height: 340)
                .frame(width: UIScreen.main.bounds.width * 0.9)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(vm.trip.tripName)
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                        Label(vm.trip.tripDestination, systemImage: "mappin")
                            .foregroundColor(.gray)
                        
                    }
                    
                    Spacer()

                    Text("$\(vm.trip.tripCostString)/PP")
                        .font(.system(size: 14))
                        .foregroundColor(Color("textColor").opacity(0.7))
                        .padding(10)
                        .fontWeight(.bold)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                }
                
                Divider()
                HStack {
                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundColor(Color("backgroundColor"))
                        .padding()
                        .background(Circle()
                            .fill(Color.gray.gradient))
                    
                    Image(systemName: "list.bullet.clipboard.fill")
                        .foregroundColor(Color("backgroundColor"))
                        .padding()
                        .background(Circle()
                            .fill(Color.gray.gradient))
                    
                    NavigationLink {
                        TripNotesView(vm: vm)
                    } label: {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "note")
                                .badge(20)
                                .foregroundColor(Color("backgroundColor"))
                                .padding()
                                .background(Circle().fill(Color("textColor").gradient))
                            
                            if let noteCount = vm.notes?.count, noteCount > 0 {
                                Text("\(noteCount)")
                                    .padding(3)
                                    .foregroundColor(Color("backgroundColor"))
                                    .font(.system(size: 14))
                                    .frame(width: 25)
                                    .background(RoundedRectangle(cornerRadius: 8).fill(.orange))
                                    .offset(x: 5,y: -8)
                            }
                        }
                        
                    }
                    
                    
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color("backgroundColor"))
                        .padding()
                        .background(Circle()
                            .fill(Color.gray.gradient))
                }
                Divider()
                            
                HStack {
                    KFImage(URL(string: vm.organizer?.profileImageUrl ?? ""))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .background(Circle().stroke(Color("textColor").opacity(0.5), lineWidth: 10))
                        .padding(.vertical, 10)
                    
                    Spacer()
                    
                    Image(systemName: "plus")
                        .foregroundColor(Color("backgroundColor"))
                        .padding(10)
                        .background(Circle().fill(Color("textColor").gradient))
                }
            
                NavigationLink("",
                               destination: TripSettingsView(vm: TripSettingsViewModel(trip: vm.trip)),
                               isActive: $vm.goToTripSettings)
                
                Text("Description")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                
                
                Text(vm.trip.tripDescription ?? "")
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, Spacing.twentyone)
            
            
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: vm.tripCoordinates.latitude, longitude: vm.tripCoordinates.longitude), span:  MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))))
                .frame(width: 350, height: 300)
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
        }
        .navigationTitle("Trip Details")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    print("setting screens")
                    vm.goToTripSettings = true
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                }
            }
        }
//        #if DE
//        .onAppear {
//            vm.fetchMembers()
//            vm.fetchNotes()
//        }
    }
}

struct GroupPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPlannerView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
