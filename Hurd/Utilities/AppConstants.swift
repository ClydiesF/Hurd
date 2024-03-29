//
//  AppConstants.swift
//  Hurd
//
//  Created by clydies freeman on 1/5/23.
//

import Foundation
import Firebase
import FirebaseStorage

//firestore
let db = Firestore.firestore()

let USER_REF = db.collection("Users")
let HURD_REF = db.collection("Hurds")
let TRIP_REF = db.collection("Trips")
let TRIPSUGGEST_REF = db.collection("TripSuggestions")
let ITINERARY_REF = db.collection("Itineraries")


enum TripTypeIcons: String {
    case vacation = "beach.umbrella"
    case cruise = "sailboat.fill"
    case roadTrip = "car.fill"
    case adventure = "figure.hiking"
    case business = "suitcase.fill"
    case excursion = "figure.play"
    case none = ""
}

// Storage

let storage = Storage.storage()

let storageRef = storage.reference()

let profileAvatars = storageRef.child("profileAvatars")

enum Spacing {
    static let four: CGFloat = 4
    static let eight: CGFloat = 8
    static let eleven: CGFloat = 11
    static let sixteen: CGFloat = 16
    static let twentyone: CGFloat = 21
    static let twentyfour: CGFloat = 24
    static let thirtytwo: CGFloat = 32
    static let thirtyFour: CGFloat = 34
    static let fortyFive: CGFloat = 45
    static let fortyeight: CGFloat = 48
    static let sixtyfour: CGFloat = 64
}

let randomText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque hendrerit est non erat euismod dignissim. Praesent vitae dignissim tellus. In a hendrerit mi, sit amet porta ex. Pellentesque molestie nisi fringilla rhoncus varius. Quisque eu iaculis purus. Curabitur dolor lectus, laoreet non hendrerit eu, tempus pulvinar tortor. Donec at risus neque. Suspendisse ex mi, tempus a vestibulum ut, rhoncus vitae orci. Nullam et placerat tellus. Aenean sapien orci, scelerisque et mi sit amet, interdum pulvinar nulla.\n\nIn pellentesque molestie purus, vitae aliquet lectus porttitor sit amet. Etiam dui sem, congue bibendum tempor id, malesuada non diam. Suspendisse neque lacus, facilisis consectetur condimentum ac, dignissim vel elit. Suspendisse semper iaculis risus, ut bibendum nisi placerat ac. Maecenas nec ipsum cursus, elementum nisl eget, egestas quam. Vivamus cursus pharetra vehicula. Ut consectetur pharetra lectus at dignissim. Quisque vitae est eget tortor gravida eleifend non sed augue. Phasellus fringilla libero sit amet risus volutpat mollis. Aliquam rutrum ligula at laoreet varius. Nam a justo ut odio elementum fermentum vel ac risus. Vivamus sit amet consequat neque, non sollicitudin purus. Nam urna neque, ultrices sed porta at, aliquet vel neque.\n\nMaecenas a dui auctor, facilisis massa sit amet, consequat lorem. Nulla congue ac elit eu congue. Proin sed justo vitae lorem ornare tincidunt vitae non dui. Aliquam erat mauris, pharetra eu augue vel, iaculis molestie ante. Integer scelerisque diam in blandit viverra. In finibus est mi, at tristique dui rhoncus a. Praesent eu libero sit amet enim commodo dignissim ac sit amet lorem. Aenean facilisis facilisis nisi, sed hendrerit lacus hendrerit aliquam."


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
