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
import BranchSDK

struct GroupPlannerView: View {
    
    @ObservedObject var vm: GroupPlannerViewModel
    @ObservedObject var router = Router()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                // Image Stack
                VStack {
                    HStack {
                        Spacer()
                        //Info Stack
                        VStack(spacing: 10) {
                            TripDateView(tripDate: vm.trip.tripStartDate)
                            
                            TripDateView(tripDate: vm.trip.tripEndDate)
                            
                            Image(systemName: vm.trip.iconName)
                                .foregroundColor(Color("backgroundColor"))
                                .padding()
                                .background(Circle().fill(Color("textColor").gradient))
                            
                        }
                        .padding(.horizontal, 10)
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
                HStack(alignment: .top,spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        HStack {
                            Text(vm.trip.tripName)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            Text("\(14)D : \(11)H")
                                .font(.system(size: 13))
                                .fontWeight(.semibold)
                                .padding(Spacing.eight)
                                .background(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
                                .background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
                        }
           
                        
                        Label(vm.trip.tripDestination,image: "locationPin")
                            .font(.system(size: 14))
                            .foregroundColor(.gray)
                        
                        
                        HStack {
                            TripInfoBlock(value: vm.trip.TripDuration, title: "Days")
                            TripInfoBlock(value: "1", title: "Hurd")
                            TripInfoBlock(value: vm.trip.tripCostString, title: "Per Person")
                            Spacer()
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
                VStack {
                    HStack {
                        Text(vm.hurd.id ?? "")
                            .font(.system(size: 12))
                            .fontWeight(.semibold)
                            .padding(Spacing.eight)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1))
                        Spacer()
                        if let url = URL(string: generateBranchTripInviteLink() ?? "") {
                            ShareLink(item: url) {
                                Image(systemName: "plus")
                                    .foregroundColor(Color("backgroundColor"))
                                    .padding(10)
                                    .background(Circle().fill(Color.gray.gradient))
                            }
                        }
                        Label("\(0) / \(5)", systemImage: "person.fill")
                            .font(.system(size: 12))
                            .padding(Spacing.eight)
                            .fontWeight(.semibold)
                            .background(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1))
                        
                    }
                }
                HStack {
                    KFImage(URL(string: vm.organizer?.profileImageUrl ?? ""))
                        .resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                        .background(Circle().stroke(Color("textColor").opacity(0.3), lineWidth: 2))
                        .padding(.vertical, 10)
                    
                    Spacer()
                }
                
                NavigationLink("",
                               destination: TripSettingsView(vm: TripSettingsViewModel(trip: vm.trip)),
                               isActive: $vm.goToTripSettings)
                
                Text("Overview")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                
                Text(vm.trip.tripDescription ?? "")
                    .foregroundColor(.gray)
                
                //                let qrCode = BranchQRCode()
                //                qrCode.codeColor = .white
                
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
    
    // Functions
    func generateBranchTripInviteLink() -> String? {
        let lp = BranchLinkProperties()
        lp.addControlParam("hurdID", withValue: vm.hurd.hurdID)
        lp.addControlParam("tripID", withValue: vm.trip.id)
        lp.addControlParam("nav_to", withValue: "groupPlannerView")
        lp.feature = "trip_invite"
        
        let buo = BranchUniversalObject(canonicalIdentifier: "trip/\(String(describing: vm.trip.id))")
        buo.canonicalUrl = "trip \(String(describing: vm.trip.id))"
        
        //Ex: XXXXX invited you to join XXXXXXXXX
        buo.title = "\(vm.organizer?.firstName ?? "organizer") invited you to join \(vm.trip.tripName)"
        buo.contentDescription = vm.trip.tripDescription
        buo.imageUrl = vm.trip.tripImageURLString?.photoURL
        
        buo.expirationDate = twoDaysInTheFuture()
        let url = buo.getShortUrl(with: lp)
        print("DEBUG: BUO\(String(describing: url))")
        return url
    }
    
    func twoDaysInTheFuture() -> Date {
        let currentDate = Date()
        let calendar = Calendar.current
        let components = DateComponents(day: 2)
        let futureDate = calendar.date(byAdding: components, to: currentDate)
        return futureDate!
    }
}


struct GroupPlannerView_Previews: PreviewProvider {
    static var previews: some View {
        GroupPlannerView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
    }
}
