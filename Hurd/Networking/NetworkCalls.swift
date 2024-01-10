//
//  NetworkCalls.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/17/23.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift


class NetworkCalls {
    func fetchTrip(with id: String) async -> Trip? {
        do {
            let tripDoc = try await TRIP_REF.document(id).getDocument()
            let trip =  try tripDoc.data(as: Trip.self)
            print("DEBUG: trip: \(trip)")
            return trip
            
        } catch(let err) {
            print("DEBUG: error: \(err.localizedDescription)")
            return nil
        }

    }
    
    func fetchUser(with id: String) async -> User? {
        do {
            let userDoc = try await USER_REF.document(id).getDocument()
            let user =  try userDoc.data(as: User.self)
            print("DEBUG: trip: \(user)")
            return user
            
        } catch(let err) {
            print("DEBUG: error: \(err.localizedDescription)")
            return nil
        }
    }
    
    func add(user userID: String, to hurdID: String) async -> Bool {
        
        do {
           try await HURD_REF.document(hurdID).updateData(["members" : FieldValue.arrayUnion([userID])])
            return true
        } catch(let err) {
            print("DEBUG: err \(err.localizedDescription)")
            return false
        }
    }
    
    func remove(user userID: String, from hurdID: String) async -> Bool {
        do {
           try await HURD_REF.document(hurdID).updateData(["members" : FieldValue.arrayRemove([userID])])
            return true
        } catch(let err) {
            print("DEBUG: err \(err.localizedDescription)")
            return false
        }
    }
    
    func fetchHurd(with id: String) async -> Hurd? {
        do {
            let hurdDoc = try await HURD_REF.document(id).getDocument()
            let hurd =  try hurdDoc.data(as: Hurd.self)
            print("DEBUG: hurd: \(hurd)")
            return hurd
            
        } catch(let err) {
            print("DEBUG: error: \(err.localizedDescription)")
            return nil
        }
    }
    
    func fetchMembers(of hurd:Hurd) async -> [User]? {
        guard let arrayOfUserIds = hurd.members else { return nil }
        print("DEBUG: Success \(arrayOfUserIds)")
        do {
            let snapshot = try await USER_REF.whereField("id", in: arrayOfUserIds).getDocuments()
            
            let users = snapshot.documents.compactMap { doc in
                let result = Result { try doc.data(as: User.self) }
                
                switch result {
                case .success(let user):
                    print("DEBUG: Success \(user)")
                    return user
        
                case .failure(let err):
                    switch err {
                    case DecodingError.typeMismatch(_,_):
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.valueNotFound(_,_):
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.keyNotFound(_,_):
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.dataCorrupted(_):
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    default:
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    }
                    return nil
                }
            }
            print("DEBUG: Success --- \(users)")
            
            return users
    
        } catch(let err) {
            print("DEBUG: error: \(err.localizedDescription)")
            return nil
        }

     
    }
}
