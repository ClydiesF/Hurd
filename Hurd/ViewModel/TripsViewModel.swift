//
//  TripsViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/16/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import Combine
import WidgetKit

class TripViewModel : ObservableObject {
    
    @Published var trips: [Trip] = []
    @Published var currentDate = Date().timeIntervalSince1970
    @Published var viewDidLoad: Bool = false
    @Published var user: User?
    @Published var selection: Int = 0
    
    @Published var errorMessage: String?
    
    @Published var isPastTrip: Bool = false
    
    
    private var listenerRegistration: ListenerRegistration?
    private var listenerRegistrationV2: ListenerRegistration?
    
    init() {
        $selection
            .receive(on: RunLoop.main)
            .map { $0 == 1 ? true : false }
            .assign(to: &$isPastTrip)
    }
    
    func getUser() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }

        USER_REF.document(currentUserID).getDocument { snapshot, err in
            if let err = err {
                print("DEBUG: err \(err.localizedDescription)")
            } else {
                do {
                    let user = try snapshot?.data(as: User.self)
                    self.user = user
                } catch {
                    print("DEBUG: err Could decode trip Object")
                }
            }
        }
    }
    
    
    func subscribe() {
        guard let currentUserID = Auth.auth().currentUser?.uid else { return }

        
        if listenerRegistration == nil {
            listenerRegistration = TRIP_REF.whereField("hurd.organizer", isEqualTo: currentUserID).addSnapshotListener({ snapshot, err in
                guard let docs = snapshot?.documents else {
                    self.errorMessage = "No documents in trip collection"
                    return
                }
                
                let tripsAsOrganizer = docs.compactMap { doc in
                    let result = Result { try doc.data(as: Trip.self)}
                    
                    switch result {
                    case .success(let trip):
                            self.errorMessage = nil
                             return trip
                    case .failure(let err):
                        switch err {
                        case DecodingError.typeMismatch(_, let context):
                            self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        case DecodingError.valueNotFound(_, let context):
                            self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        case DecodingError.keyNotFound(_, let context):
                            self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        case DecodingError.dataCorrupted(let key):
                            self.errorMessage = "\(err.localizedDescription): \(key)"
                        default:
                            self.errorMessage = "Error decoding document: \(err.localizedDescription)"
                        }
                        return nil
                    }
                }
                
                self.trips.append(contentsOf: tripsAsOrganizer)
            })
        }
        
        if listenerRegistrationV2 == nil {
            listenerRegistrationV2 = TRIP_REF.whereField("hurd.members", arrayContains: currentUserID).addSnapshotListener({ snapshot, err in
                guard let docs = snapshot?.documents else {
                    self.errorMessage = "No documents in trip collection"
                    return
                }
                
                let tripsAsMember = docs.compactMap { doc in
                    let result = Result { try doc.data(as: Trip.self)}
                    
                    switch result {
                    case .success(let trip):
                            self.errorMessage = nil
                             return trip
                    case .failure(let err):
                        switch err {
                        case DecodingError.typeMismatch(_, let context):
                            self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        case DecodingError.valueNotFound(_, let context):
                            self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        case DecodingError.keyNotFound(_, let context):
                            self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        case DecodingError.dataCorrupted(let key):
                            self.errorMessage = "\(err.localizedDescription): \(key)"
                        default:
                            self.errorMessage = "Error decoding document: \(err.localizedDescription)"
                        }
                        return nil
                    }
                }
                self.trips.append(contentsOf: tripsAsMember)
            })
        }
        
        // This is for widgets only
        // take the trip that is closet to the current date
        guard let closestTrip = self.closestTrip(trips: self.trips), let photoString = closestTrip.tripImageURLString?.photoURL else { return }
        
        
        // then i want to assign those vaibles to the user default
        let userDefault = UserDefaults(suiteName: "group.widgetTripCache")
        
        userDefault?.setValue(closestTrip.tripName, forKeyPath: "tripName")
        let stringDate = String(Date(timeIntervalSince1970: closestTrip.tripStartDate).formatted(date: .numeric, time: .omitted))
        userDefault?.setValue(stringDate, forKeyPath: "startDate")
        userDefault?.setValue(closestTrip.countDownTimer["days"], forKeyPath: "countdownDays")
        userDefault?.setValue(photoString, forKey: "photoImage")
        userDefault?.setValue(closestTrip.iconName, forKey: "icon")
        // tthen i want to refresh the widget.
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func closestTrip(trips: [Trip]) -> Trip? {
      let currentDate = Date()
      var closestTrip: Trip? = nil
      var closestDifference: TimeInterval = .infinity
      for trip in trips {
          // ignore past due trips
          if trip.tripStartDate < currentDate.timeIntervalSince1970 { continue }
          
          let startDate = Date(timeIntervalSince1970: trip.tripStartDate)
          let difference = startDate.timeIntervalSince(currentDate)
          
        if difference < closestDifference {
          closestDifference = difference
          closestTrip = trip
        }
      }
      return closestTrip
    }
}
