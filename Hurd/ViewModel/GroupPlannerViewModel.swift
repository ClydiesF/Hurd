//
//  GroupPlannerViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/14/23.
//

import Foundation
import SwiftUI
import Firebase

class GroupPlannerViewModel: ObservableObject {
    
    @Published var trip: Trip
    @Published var hurd: Hurd
    
    @Published var organizer: User?
    @Published var members: [User]?
    
    @Published var errorMessage: String?
    
    init(trip: Trip, hurd: Hurd) {
        self.trip = trip
        self.hurd = hurd
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
