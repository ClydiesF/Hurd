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
import FirebaseAuth
import MapKit
import Alamofire
import BranchSDK

//struct GroupPlannerView: View {
//    
//    @ObservedObject var vm: GroupPlannerViewModel
//    @EnvironmentObject var router: Router
//    @State var countDownString = ""
//    @State var showInviteAcceptance: Bool = true
//    
//    var body: some View {
//        ZStack {
//            ScrollView {
//                VStack(alignment: .leading) {
//                    // Image Stack
//                    VStack {
//                        HStack {
//                            Spacer()
//                            //Info Stack
//                            VStack(spacing: 10) {
//                                TripDateView(tripDate: vm.trip.tripStartDate)
//                                
//                                TripDateView(tripDate: vm.trip.tripEndDate)
//                                
//                                Image(systemName: vm.trip.iconName)
//                                    .foregroundColor(Color("backgroundColor"))
//                                    .padding()
//                                    .background(Circle().fill(Color("textColor").gradient))
//                                
//                            }
//                            .padding(.horizontal, 10)
//                        }
//                        //Authur Label
//                        HStack {
//                            if let authorName = vm.trip.tripImageURLString?.authorName {
//                                Label(authorName, systemImage: "camera.fill")
//                                    .foregroundColor(.white)
//                                Spacer()
//                            }
//                        }
//                        .padding(10)
//                        
//                    }
//                    .padding(.top, 10)
//                    .background(
//                        KFImage(URL(string: vm.trip.tripImageURLString?.photoURL ?? ""))
//                            .resizable()
//                            .overlay {
//                                Color("textColor").opacity(0.2)
//                            }
//                    )
//                    .clipShape(RoundedRectangle(cornerRadius: 10))
//                    
//                    // Trip Info STack v2
//                    HStack(alignment: .top,spacing: 10) {
//                        VStack(alignment: .leading, spacing: 5) {
//                            HStack {
//                                Text(vm.trip.tripName)
//                                    .font(.system(size: 20))
//                                    .fontWeight(.bold)
//                                
//                                Spacer()
//                                
//                                Text(self.countDownString)
//                                    .font(.system(size: 13))
//                                    .fontWeight(.semibold)
//                                    .padding(Spacing.eight)
//                                    .background(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
//                                    .background(RoundedRectangle(cornerRadius: 5).fill(Color.gray.opacity(0.1)))
//                            }
//                            
//                            
//                            Label(vm.trip.tripDestination,image: "locationPin")
//                                .font(.system(size: 14))
//                                .foregroundColor(.gray)
//                            
//                            
//                            HStack {
//                                TripInfoBlock(value: vm.trip.TripDuration, title: "Days")
//                                TripInfoBlock(value: "1", title: "Hurd")
//                                TripInfoBlock(value: vm.trip.tripCostString, title: "Per Person")
//                                Spacer()
//                            }
//                        }
//                    }
//                    
//                    Divider()
//                    
//                    HStack {
//                        Image(systemName: "speaker.wave.3.fill")
//                            .foregroundColor(Color("backgroundColor"))
//                            .padding()
//                            .background(Circle()
//                                .fill(Color.gray.gradient))
//                        
//                        Image(systemName: "list.bullet.clipboard.fill")
//                            .foregroundColor(Color("backgroundColor"))
//                            .padding()
//                            .background(Circle()
//                                .fill(Color.gray.gradient))
//                        
//                        NavigationLink {
//                            TripNotesView(vm: vm)
//                        } label: {
//                            ZStack(alignment: .topTrailing) {
//                                Image(systemName: "note")
//                                    .badge(20)
//                                    .foregroundColor(Color("backgroundColor"))
//                                    .padding()
//                                    .background(Circle().fill(Color("textColor").gradient))
//                                
//                                if let noteCount = vm.notes?.count, noteCount > 0 {
//                                    Text("\(noteCount)")
//                                        .padding(3)
//                                        .foregroundColor(Color("backgroundColor"))
//                                        .font(.system(size: 14))
//                                        .frame(width: 25)
//                                        .background(Circle().fill(.orange))
//                                        .offset(x: 5,y: -8)
//                                }
//                            }
//                            
//                        }
//                    }
//                    
//                    Divider()
//                    VStack {
//                        HStack {
//                            if let hurdID = vm.hurd.id {
//                                Text(vm.hurd.name ?? vm.hurd.hurdID ?? "")
//                                    .font(.system(size: 12))
//                                    .fontWeight(.semibold)
//                                    .padding(Spacing.eight)
//                                    .background(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1))
//                            }
//                         
//                            Spacer()
//                            if let url = URL(string: generateBranchTripInviteLink() ?? "") {
//                                ShareLink(item: url) {
//                                    Image(systemName: "plus")
//                                        .foregroundColor(Color("backgroundColor"))
//                                        .padding(10)
//                                        .background(Circle().fill(Color.gray.gradient))
//                                }
//                            }
//                            Label("\(vm.members?.count ?? 0) / \(vm.hurd.capacity ?? 5)", systemImage: "person.fill")
//                                .font(.system(size: 12))
//                                .padding(Spacing.eight)
//                                .fontWeight(.semibold)
//                                .background(RoundedRectangle(cornerRadius: 8).stroke(.gray, lineWidth: 1))
//                            
//                        }
//                    }
//   
//                    
//                    Text("Overview")
//                        .font(.system(size: 20))
//                        .fontWeight(.bold)
//                    
//                    Text(vm.trip.tripDescription ?? "")
//                        .foregroundColor(.gray)
//                    
//                    //                let qrCode = BranchQRCode()
//                    //                qrCode.codeColor = .white
//                    
//                    //                Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: vm.tripCoordinates.latitude, longitude: vm.tripCoordinates.longitude), span:  MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))))
//                    //                    .frame(width: 250, height: 200)
//                    //                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                    
//                    
//                }// END VSTACK
//                .padding(.horizontal)
//            }// END ScrollView
//            .onAppear(perform: {
//                _ = timer
//            })
////            .navigationDestination(for: Destination.self) { destination in
////                switch destination {
////                case .groupPlannerView(let trip, let hurd):
////                    GroupPlannerView(vm:GroupPlannerViewModel(trip: trip, hurd: hurd))
////                case .profile:
////                    ProfileView(vm: ProfileViewModel(user: User.mockUser1))
////                case .settings:
////                    TripSettingsView(vm: TripSettingsViewModel(trip: vm.trip))
////                case .notes:
////                    TripNotesView(vm: vm)
////                }
////            }
//            .padding(.bottom, Spacing.sixteen)
//            .navigationTitle("Trip Details")
//            .navigationBarTitleDisplayMode(.inline)
//            .toolbar {
//                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    if let url = URL(string: generateBranchTripInviteLink() ?? "") {
//                        ShareLink(item: url) {
//                            Image(systemName: "square.and.arrow.up")
//                        }
//                    }
//                }
//                
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        print("setting screens")
//                        router.navigate(to: .settings)
//                    } label: {
//                        Image(systemName: "ellipsis")
//                            .font(.title3)
//                    }
//                }
//                
//            }
//            .onAppear {
////                vm.fetchNotes()
////                self.countDownString = countDownString(from: Date())
////                _ = timer
////                
////                Task {
////                    let nc = NetworkCalls()
////                    guard let hurd = await nc.fetchHurd(with: vm.hurd.hurdID ?? "") else { return }
////                    vm.members = await nc.fetchMembers(of: hurd)
////                    vm.organizer = await nc.fetchUser(with: hurd.organizer ?? "")
////                }
//        }
//            if !vm.isUser(userID: Auth.auth().currentUser?.uid ?? "", aMemberOf: vm.hurd) && showInviteAcceptance {
//                VStack {
//                    Spacer()
//                    VStack {
//                        Text("Do you want to join this trip?")
//                            .fontWeight(.semibold)
//                            .font(.system(size: 13))
//                        HStack {
//                            Button {
//                                // Implement code to except here
//                                print("DEBUG: decline")
//                                showInviteAcceptance = false
//                                
//                                // remove case for tripInvitations in firebase
//                                
//                                
//                            } label: {
//                                Text("Decline")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.red).brightness(0.5)
//                                    .padding(15)
//                                    .background(RoundedRectangle(cornerRadius: 10).fill(.red))
//                            }
//                            
//                            Button {
//                                // Implement code to except here
//                                print("DEBUG: Accept")
//                                showInviteAcceptance = false
//                                // add User to the hurd case for tripInvitations in firebase
//                                Task {
//                                    let nc = NetworkCalls()
//                                    let didAdd = await nc.add(user: Auth.auth().currentUser?.uid ?? "", to: vm.hurd.id ?? "")
//                                }
//                           
//                            } label: {
//                                Text("Accept")
//                                    .fontWeight(.semibold)
//                                    .frame(maxWidth: .infinity)
//                                    .foregroundColor(.green).brightness(-0.5)
//                                    .padding(15)
//                                    .background(RoundedRectangle(cornerRadius: 10).fill(.green))
//                            }
//              
//
//                        }
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 10).fill(.white).shadow(color: .gray.opacity(0.3), radius: 5, x: 3, y: 3))
//                }
//                .animation(.easeInOut(duration: 0.5), value: showInviteAcceptance)
//                .frame(width: UIScreen.main.bounds.size.width * 0.85)
//            }
//       
//        }
//    }
//    
//    // Functions
//     var timer: Timer {
//         Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {_ in
//             self.countDownString = countDownString(from: Date())
//         }
//     }
//    
//    func countDownString(from date: Date) -> String {
//        
//        let startDate = Date(timeIntervalSince1970: vm.trip.tripStartDate)
//        let calendar = Calendar(identifier: .gregorian)
//        let components = calendar
//            .dateComponents([.day, .hour, .minute],
//                            from: date,
//                            to: startDate)
//        return String(format: "%02dd:%02dh:%02dm",
//                      components.day ?? 00,
//                      components.hour ?? 00,
//                      components.minute ?? 00)
//    }
//    
//    
//    
////    func generateBranchTripInviteLink() -> String? {
////        let lp = BranchLinkProperties()
////        lp.addControlParam("hurdID", withValue: vm.hurd.hurdID)
////        lp.addControlParam("tripID", withValue: vm.trip.id)
////        lp.addControlParam("nav_to", withValue: "groupPlannerView")
////        lp.feature = "trip_invite"
////        
////        let buo = BranchUniversalObject(canonicalIdentifier: "trip/\(String(describing: vm.trip.id))")
////        buo.canonicalUrl = "trip \(String(describing: vm.trip.id))"
////        
////        //Ex: XXXXX invited you to join XXXXXXXXX
////        buo.title = "\(vm.organizer?.firstName ?? "organizer") invited you to join \(vm.trip.tripName)"
////        buo.contentDescription = vm.trip.tripDescription
////        buo.imageUrl = vm.trip.tripImageURLString?.photoURL
////        
////        buo.expirationDate = twoDaysInTheFuture()
////        let url = buo.getShortUrl(with: lp)
////        print("DEBUG: BUO\(String(describing: url))")
////        return url
////    }
//    
//    func twoDaysInTheFuture() -> Date {
//        let currentDate = Date()
//        let calendar = Calendar.current
//        let components = DateComponents(day: 2)
//        let futureDate = calendar.date(byAdding: components, to: currentDate)
//        return futureDate!
//    }
//}
//
//
//struct GroupPlannerView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupPlannerView(vm: GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd))
//    }
//}
