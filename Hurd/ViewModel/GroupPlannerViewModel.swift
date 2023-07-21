//
//  GroupPlannerViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/14/23.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import CoreLocation

class GroupPlannerViewModel: ObservableObject {
    
    @Published var trip: Trip
    @Published var hurd: Hurd
    
    @Published var organizer: User?
    @Published var members: [User]?
    
    // Trip Settings
    @Published var goToTripSettings: Bool = false
    
    //Notes
    @Published var notes: [Note]?
    
    @Published var title: String = ""
    @Published var bodyText: String = ""
    @Published var noteType: String = NoteType.generalNote.rawValue
    
    let noteTypes = ["Important", "General Note"]
    
    @Published var errorMessage: String?
    
    @Published var noteSuccessDeleted: Bool = false
    
    var timeRemaingTillTrip: String?
    
    @Published var presentTripCancellationSheet: Bool = false
    
    @Published var showAddNoteForm: Bool = false
    @Published var tripCoordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 50, longitude: 50)
    
    init(trip: Trip, hurd: Hurd) {
        self.trip = trip
        self.hurd = hurd
        
        calculateTimeRemaining(from: trip.tripStartDate)
        getCoordinateFrom(address: trip.tripDestination) { coordinate, error in
            
            guard let coordinate = coordinate, error == nil else { return }
             // don't forget to update the UI from the main thread
             DispatchQueue.main.async {
                 print("DEBUG", "Location:", coordinate) // Rio de Janeiro, Brazil Location: CLLocationCoordinate2D(latitude: -22.9108638, longitude: -43.2045436)
                 self.tripCoordinates = coordinate
             }
        
        }
    }
    
    func calculateTimeRemaining(from tripDate: Double) {
        let dateFromDouble = Date(timeIntervalSince1970: tripDate)
        let diffs = Calendar.current.dateComponents([.day,.hour, .weekOfYear, .month], from: Date(), to: dateFromDouble)
        let arr = [diffs.month,diffs.weekOfYear,diffs.day, diffs.hour]
        
        timeRemaingTillTrip = "\(diffs.month ?? 0)M " + "\(diffs.weekOfYear ?? 0)W " + "\(diffs.day ?? 0)D " + "\(diffs.hour ?? 0)h "
    }
    
    func deleteNote(with noteId: String) {
        _ = TRIP_REF.document(self.trip.id ?? "").collection("Notes").document(noteId).delete(completion: { err in
            if let err = err  {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            self.noteSuccessDeleted = true
            
        })
    }
    
   

    func getCoordinateFrom(address: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> () ) {
        CLGeocoder().geocodeAddressString(address) { completion($0?.first?.location?.coordinate, $1) }
    }
    
    func addNote() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let dict: [String: Any] = ["title": self.title,
                                   "body": self.bodyText ,
                                   "noteType": self.noteType,
                                       "authorID": userID,
                                       "timestamp": Date().timeIntervalSince1970
            ]
            
            _ = TRIP_REF.document(self.trip.id ?? "").collection("Notes").addDocument(data: dict)
        self.title = ""
        self.bodyText = ""
        showAddNoteForm = false
    }
    
    
    func fetchNotes() {
        TRIP_REF.document(self.trip.id ?? "").collection("Notes").addSnapshotListener { snapshot, err in
            if let err = err  {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            
            guard let docs = snapshot?.documents else {
                self.errorMessage = "No Docs"
                return
            }
            
            var notes = docs.compactMap { doc in
                let result = Result { try doc.data(as: Note.self) }
                
                switch result {
                case .success(let note):
                    //self.errorMessage = nil
                    return note
                case .failure(let err):
                    switch err {
                    case DecodingError.typeMismatch(_, let context):
                        self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.valueNotFound(_, let context):
                        self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.keyNotFound(_, let context):
                        self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.dataCorrupted(let key):
                        self.errorMessage = "\(err.localizedDescription): \(key)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    default:
                        self.errorMessage = "Error decoding document: \(err.localizedDescription)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    }
                    return nil
                }
            }
            self.notes = notes
        }
    }
    
    
    // For Members
    func leaveTrip() {
        //deltes the trip document
    }
    
    func fetchMembers() {
        var userIDs: [String] = [self.hurd.organizer]
        
        USER_REF.whereField("id", in: userIDs).getDocuments { snapshot, err in
            if let err = err  {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            
            guard let docs = snapshot?.documents else {
                self.errorMessage = "No Docs"
                return
            }
    
            
            var users = docs.compactMap { doc in
                let result = Result { try doc.data(as: User.self) }
                
                switch result {
                case .success(let user):
                    //self.errorMessage = nil
                    return user
                case .failure(let err):
                    switch err {
                    case DecodingError.typeMismatch(_, let context):
                        self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.valueNotFound(_, let context):
                        self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.keyNotFound(_, let context):
                        self.errorMessage = "\(err.localizedDescription): \(context.debugDescription)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.dataCorrupted(let key):
                        self.errorMessage = "\(err.localizedDescription): \(key)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    default:
                        self.errorMessage = "Error decoding document: \(err.localizedDescription)"
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    }
                    return nil
                }
            }
            self.organizer = users.popLast()
            self.members = users
        }   
    }
}
