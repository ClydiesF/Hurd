//
//  Note.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/20/24.
//

import Foundation
import FirebaseFirestoreSwift

enum NoteType: String, CaseIterable {
    case important = "Important"
    case generalNote = "General Note"
    
    var iconString: String {
        switch self {
        case .important:
            return "exclamationmark.triangle.fill"
        case .generalNote:
            return "note.text"
        }
    }
}

struct Note: Codable, Hashable {
    @DocumentID var id: String?
    var title: String
    var body: String
    var noteType: String
    var timestamp: Double
    var authorID: String
}

extension Note {
    static let mockNote = Note(id: UUID().uuidString, title: "Passport 🧨", body: "Everyone remember to bring your passports please", noteType: NoteType.important.rawValue, timestamp: 3434324233, authorID: UUID().uuidString)
    
    static let mockNote2 = Note(id: UUID().uuidString, title: "Hurd Rules 🦬", body: "Everyone remember to bring your passports please", noteType: NoteType.generalNote.rawValue, timestamp: 3434324233, authorID: UUID().uuidString)
}

