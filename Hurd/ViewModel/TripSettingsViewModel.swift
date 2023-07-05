//
//  TripSettingsViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 2/16/23.
//

import Foundation

class TripSettingsViewModel: ObservableObject {
    
    @Published var trip: Trip
    @Published var presentTripCancellationSheet = false
    @Published var presentEditTripSheet = false
    
    init(trip: Trip) {
        self.trip = trip
    }
    
    // MARK: - METHODS
    // For Organizers.
    func cancelTrip() {
        // deletes an  field from the field propery or updates it less the person who is kicked out.
        guard let tripID = trip.id else { return }
        
        print("DEBUG: err -\(tripID)")
        TRIP_REF.document(tripID).delete { err in
            if let err = err {
                print("DEBUG: Erro removing  document: \(err)")
            } else {
                print("DEBUG: Document successfully removed!")
//                HURD_REF.document(hurdID).delete { err in
//                    if let err = err {
//                        print("DEBUG: Erro removing  document: \(err)")
//                    }
//                }
            }
        }
    }
    
    
}
