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
                        .overlay {
                            Color.black.opacity(0.2)
                        }
                    
                    HStack(alignment: .bottom) {
                        Text(vm.trip.tripImageURLString?.authorName ?? "")
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        VStack(alignment: .trailing,spacing: 0) {
                            TripDateView(tripDate: vm.trip.tripStartDate)
                                .padding(.bottom,10)
                            
                            TripDateView(tripDate: vm.trip.tripEndDate)
                                .padding(.bottom,10)
                            
                            Image(systemName: "car.fill")
                                .foregroundColor(.white)
                                .padding()
                                .background(Circle().fill(.black))
                            
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
                        .foregroundColor(.black.opacity(0.7))
                        .padding(10)
                        .fontWeight(.bold)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                }
                
                Divider()
                HStack {
                    Image(systemName: "speaker.wave.3.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(.black))
                    
                    Image(systemName: "list.bullet.clipboard.fill")
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(.black))
                    
                    Image(systemName: "note")
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(.black))
                    
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.white)
                        .padding()
                        .background(Circle().fill(.black))
                }
                Divider()
                            
                HStack {
                    KFImage(URL(string: vm.organizer?.profileImageUrl ?? ""))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .background(Circle().stroke(Color.black.opacity(0.5), lineWidth: 10))
                        .padding(.vertical, 10)
                    
                    Spacer()
                    
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .padding(10)
                        .background(Circle().fill(.black))
                }
                
                Text("Description")
                    .font(.system(size: 25))
                    .fontWeight(.bold)
                
                Text(vm.trip.tripDescription ?? "")
                    .foregroundColor(.gray)
                
                //            if let imageString = vm.organizer?.profileImageUrl {
                //                KFImage(URL(string: imageString))
                //                    .placeholder {
                //                        // Placeholder while downloading.
                //                        Image("mockAvatarImage")
                //                            .font(.largeTitle)
                //                            .opacity(0.3)
                //                    }
                //                    .retry(maxCount: 3, interval: .seconds(5))
                //                    .onSuccess { r in
                //                        // r: RetrieveImageResult
                //                        print("success: \(r)")
                //                    }
                //                    .onFailure { e in
                //                        // e: KingfisherError
                //                        print("failure: \(e)")
                //                    }
                //                    .resizable()
                //                    .frame(width: 50, height: 50)
                //                    .scaledToFit()
                //                    .clipShape(Circle())
                //            }
                //            Label(vm.timeRemaingTillTrip ?? "", systemImage: "clock")
                //                .font(.system(size: 14))
                //                .foregroundColor(.black)
                //                .padding(5)
                //                .background(Capsule().fill(Color.white))
                //                .padding(.horizontal, 10)
                //                .padding(.top, 10)
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
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.title3)
                }
            }
        }
        .onAppear {
            vm.fetchMembers()
        }
    }
}

struct GroupPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPlannerView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}


//        ScrollView {
//            VStack(alignment: .leading, spacing: 10) {
//
//
//
//                HStack(spacing: 15) {
//
//                    Label("Broadcast", systemImage: "speaker.wave.3.fill")
//                        .font(.system(size: 14))
//                        .padding(8)
//                        .background(Capsule().stroke(Color.gray.opacity(0.5)))
//
//                    Label("Planner", systemImage: "list.bullet.clipboard.fill")
//                        .font(.system(size: 14))
//                        .padding(8)
//                        .background(Capsule().stroke(Color.gray.opacity(0.5)))
//
//                    NavigationLink {
//                        TripNotesView(vm: vm)
//                    } label: {
//                        Label("Notes", systemImage: "note")
//                            .font(.system(size: 14))
//                            .padding(8)
//                            .background(Capsule().stroke(Color.gray.opacity(0.5)))
//                    }
//
//
//                }
//                .frame(height: 30)
//                .padding(.leading, 10)
//
//                Divider()
//                //TRIP DETAIL VIEW
//                TripDetailView(trip: $vm.trip)
//
//                Divider()
//                    .padding(.bottom, 10)
//
//                HurdView(organizer: $vm.organizer, members: $vm.members, trip: $vm.trip)
//
//                Divider()
//                    .padding(.bottom, 10)
//
//                HStack(spacing: 15) {
//                    Button {
//                        vm.presentTripCancellationSheet = true
//                    } label: {
//                        Label("Cancel Trip", systemImage: "xmark")
//                            .foregroundColor(.red)
//                            .font(.system(size: 14))
//                            .padding(8)
//                            .background(Capsule().stroke(Color.red))
//                    }
//
//                    NavigationLink {
//                        AddTripFormView(vm: returnPrepopulatedVM())
//                    } label: {
//                        Label("Edit Trip", systemImage: "pencil")
//                            .font(.system(size: 14))
//                            .padding(8)
//                            .background(Capsule().stroke(Color.gray.opacity(0.5)))
//                    }
//
//
//
//                    Label("Share Trip", systemImage: "square.and.arrow.up")
//                        .font(.system(size: 14))
//                        .padding(8)
//                        .background(Capsule().stroke(Color.gray.opacity(0.5)))
//                }
//                .frame(height: 30)
//                .padding(.leading, 10)
//
//            }
//            .onAppear{
//                vm.fetchMembers()
//            }
//        }
//
//        .sheet(isPresented: $vm.presentTripCancellationSheet, content: {
//            VStack(alignment: .leading) {
//                Text("Are you sure?")
//                    .font(.largeTitle)
//                    .padding(.bottom, 10)
//                Text("Deleting this trip will remove this trip from everyone else in the Hurd as well.")
//                    .font(.system(size: 14))
//                    .foregroundColor(.gray)
//                    .padding(.bottom, 20)
//
//                HStack {
//                    Button("Keep Trip") {
//                        // Dismiss
//                        vm.presentTripCancellationSheet = false
//                    }
//                    Spacer()
//                    Button("Cancel Trip") {
//                        // Dismiss
//                        vm.cancelTrip()
//                        vm.presentTripCancellationSheet = false
//                    }
//                }
//            }
//            .padding(.horizontal)
//            .presentationDetents([.height(220)])
//            .presentationDragIndicator(.visible)
//        })
//        .navigationTitle("Trip Details")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Button {
//                    print("setting screens")
//                } label: {
//                    Image(systemName: "ellipsis")
//                }
//            }
//        }
//    }
//    ///Func
//
//    func returnPrepopulatedVM() -> AddTripFormViewModel {
//        let vm = AddTripFormViewModel()
//        vm.prepopulateValuesFrom(current: self.vm.trip)
//        return vm
//    }
