//
//  Hurd.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/20/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Hurd: Codable {
    @DocumentID var id: String?
    var name: String?
    var description: String?
    var isLocked: Bool = false
    var members: [String]?
    var organizer: String
    var hurdID: String?
    var capacity: Int = 5
}

extension Hurd {
    // MOCKS
    static let mockHurd = Hurd(id: "36365r6457623", name: "The Hooligans", description: "This trip is for Pauls Bacherlor party. this will be a grrest time for him and were going to have a blast.", members: ["","",""], organizer: "727812gy7812g", hurdID: nil, capacity: 5)
    static let mockHurdNoName = Hurd(id: "36365r6457623", members: [""], organizer: "727812gy7812g", hurdID: nil, capacity: 5)
    static let mockHurdLocked = Hurd(id: "36365r6457623", name: "The Hooligans", isLocked: true, members: ["","",""], organizer: "727812gy7812g", hurdID: nil, capacity: 5)
    
    var hurdName: String {
        if let name  {
            return name
        }
        
        return id ?? ""
    }
    
    var memberCount: Int {
        if let members {
            return members.count
        }
        
        return 0
    }
}
