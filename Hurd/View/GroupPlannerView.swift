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
                // Image Stack
                VStack {
                    HStack {
                        Spacer()
                        //Info Stack
                        VStack {
                            TripDateView(tripDate: vm.trip.tripStartDate)
                                .padding(.bottom,10)
                            
                            TripDateView(tripDate: vm.trip.tripEndDate)
                                .padding(.bottom,10)
                            
                            Image(systemName: vm.trip.iconName)
                                .foregroundColor(Color("backgroundColor"))
                                .padding()
                                .background(Circle().fill(Color("textColor").gradient))
                            
                            Spacer()
                        }
                        .padding(10)
                    }
                    //Authur Label
                    HStack {
                        if let authorName = vm.trip.tripImageURLString?.authorName {
                            Label(authorName, systemImage: "camera.fill")
                                .foregroundColor(.white)
                            Spacer()
                        }
                    }
                    .padding(10)
                    
                }
                .padding(.top, 10)
                .background(
                    KFImage(URL(string: vm.trip.tripImageURLString?.photoURL ?? ""))
                        .resizable()
                        .overlay {
                            Color("textColor").opacity(0.2)
                        }
                )
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                // Trip Info STack v2
                HStack(spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        Label(vm.trip.tripDestination,image: "locationPin")
                            .font(.system(size: 15))
                            .foregroundColor(.gray)
                        Text(vm.trip.tripName)
                            .font(.system(size: 25))
                            .fontWeight(.bold)
                        
                        HStack {
                            TripInfoBlock(value: vm.trip.TripDuration, title: "Days")
                            TripInfoBlock(value: "1", title: "Hurd")
                            TripInfoBlock(value: vm.trip.tripCostString, title: "Per Person")
                            Spacer()
                        }
                    }
                    //CountTimer
                    if let percentage = vm.trip.countdownPercentage, let cdays = vm.trip.countDownTimer["days"], cdays != 0 {
                        VStack {
                            Spacer()
                            CircularProgressView(progress: percentage, barWidth: 16, textSize: 20, countdown: vm.trip.countDownTimer)
                                .frame(width: 90, height: 90)
                        }
                    }
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
                                    .background(Circle().fill(.orange))
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
                        .background(Circle().fill(Color.gray.gradient))
                }
                
                NavigationLink("",
                               destination: TripSettingsView(vm: TripSettingsViewModel(trip: vm.trip)),
                               isActive: $vm.goToTripSettings)
                
                Text("Description")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Text(vm.trip.tripDescription ?? "")
                    .foregroundColor(.gray)
                
//                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: vm.tripCoordinates.latitude, longitude: vm.tripCoordinates.longitude), span:  MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))))
//                    .frame(width: 250, height: 200)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
            }// END VSTACK
            .padding(.horizontal)
        }// END ScrollView
        .padding(.bottom, Spacing.sixteen)
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
        .onAppear {
            vm.fetchMembers()
            vm.fetchNotes()
        }
    }
}


struct GroupPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPlannerView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
