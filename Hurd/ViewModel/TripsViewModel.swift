//
//  TripsViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/16/23.
//

import Foundation
import Firebase


class TripViewModel : ObservableObject {
    
    @Published var trips: [Trip] = []
    @Published var viewDidLoad: Bool = false
    @Published var user: User?
    @Published var selection: Int = 0
    
    @Published var errorMessage: String?
    
    
    private var listenerRegistration: ListenerRegistration?
    
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
                
                self.trips = docs.compactMap { doc in
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
            })
        }
    }
}
