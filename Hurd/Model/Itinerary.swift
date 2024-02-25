//
//  Itinerary.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/20/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Itinerary: Codable {
    @DocumentID var id: String?
    let tripID: String?
}

extension Itinerary {
    static let mockItinerary = Itinerary(tripID: "123456")
}
