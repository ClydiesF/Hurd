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

class GroupPlannerViewModel: ObservableObject {
    
    @Published var trip: Trip
    @Published var hurd: Hurd
    
    @Published var organizer: User?
    @Published var members: [User]?
    
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
    
    init(trip: Trip, hurd: Hurd) {
        self.trip = trip
        self.hurd = hurd
        
        calculateTimeRemaining(from: trip.tripStartDate)
    }
    
    func calculateTimeRemaining(from tripDate: Double) {
        let dateFromDouble = Date(timeIntervalSince1970: tripDate)
        let diffs = Calendar.current.dateComponents([.day,.hour, .weekOfYear, .month], from: Date(), to: dateFromDouble)
        let arr = [diffs.month,diffs.weekOfYear,diffs.day, diffs.hour]
        
        timeRemaingTillTrip = "\(diffs.month ?? 0)M " + "\(diffs.weekOfYear ?? 0)W " + "\(diffs.day ?? 0)D " + "\(diffs.hour ?? 0)h "
    }
    
    // For Organizers.
    func cancelTrip() {
        // deletes an  field from the field propery or updates it less the person who is kicked out.
        guard let tripID = trip.id, let hurdID = hurd.hurdID else { return }
        
        print("DEBUG: err \(hurdID) -\(tripID)")
        TRIP_REF.document(tripID).delete { err in
            if let err = err {
                print("DEBUG: Erro removing  document: \(err)")
            } else {
                print("DEBUG: Document successfully removed!")
                HURD_REF.document(hurdID).delete { err in
                    if let err = err {
                        print("DEBUG: Erro removing  document: \(err)")
                    }
                }
            }
        }
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
    
    func addNote() {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        let dict: [String: Any] = ["title": self.title,
                                   "body": self.bodyText ,
                                   "noteType": self.noteType,
                                       "authorID": userID,
                                       "timestamp": Date().timeIntervalSince1970
            ]
            
            _ = TRIP_REF.document(self.trip.id ?? "").collection("Notes").addDocument(data: dict)
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
