//
//  NetworkCalls.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/17/23.
//

import Foundation
import Firebase


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
    
    func fetchHurd(with id: String) async -> Hurd? {
        do {
            let hurdDoc = try await HURD_REF.document(id).getDocument()
            let hurd =  try await hurdDoc.data(as: Hurd.self)
            print("DEBUG: hurd: \(hurd)")
            return hurd
            
        } catch(let err) {
            print("DEBUG: error: \(err.localizedDescription)")
            return nil
        }
    }
}
