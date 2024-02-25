//
//  Activity.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/20/24.
//

import Foundation
import FirebaseFirestoreSwift

struct Activity: Codable, Hashable {
    @DocumentID var id: String?
    let type: String
    let name: String
    let location: String?
    let description: String?
    let link: String?
    let status: String?
    let startTime: Double
    let durationHours: Int?
    let durationMinutes: Int?
    let author: String // User Id
}

struct ActivityAI: Codable, Hashable {
    let type: String
    let name: String
    let location: String?
    let description: String?
    let link: String?
    let status: String?
    let startTime: Double
    let durationHours: Int?
    let durationMinutes: Int?
    let author: String // User Id
}
extension ActivityAI {
    var iconName: String {
        switch self.type {
        case "food":
            return "fork.knife"
        case "transportation":
            return "figure.walk"
        case "sports":
            return "sportscourt"
        case "flight":
            return "airplane.departure"
        case "club":
            return "figure.dance"
        case "bar":
            return "wineglass"
        case "park":
            return "leaf"
        case "museum":
            return "building.columns.fill"
        case "art":
            return "hand.draw.fill"
        case "historic site":
            return "hourglass"
        case "shopping":
            return "bag"
        default:
            return ""
        }
    }
    
    var dateComponents: (Int, Int) {
        let startDate = Date(timeIntervalSince1970: self.startTime)
        let diffs = Calendar.current.dateComponents([.day,.year, .month], from: startDate)
        
        guard let month = diffs.month, let day = diffs.day else { return (0,0) }
        
        return (month, day)
    }
}

extension Activity {
    static let mockActivity = Activity(type: "food", name: "Slutty Vegan", location: "77th Avenue Street, Boston,MA", description: "A Great place to meet poeple and eat a healthy meal. its greatQ", link: "https//www.apple.com", status: "confirmed", startTime: 1706938234, durationHours: 2, durationMinutes: 30, author: "sdjjdsjnjwklmlkmwelwe")
    
    var dateComponents: (Int, Int, Int) {
        let startDate = Date(timeIntervalSince1970: self.startTime)
        let diffs = Calendar.current.dateComponents([.day,.year, .month], from: startDate)
        
        guard let month = diffs.month, let day = diffs.day, let year = diffs.year else { return (0,0,0) }
        
        return (month, day, year)
    }
    
    
    var iconName: String {
        switch self.type {
        case "food":
            return "fork.knife"
        case "transportation":
            return "figure.walk"
        case "sports":
            return "sportscourt"
        case "flight":
            return "airplane.departure"
        case "club":
            return "figure.dance"
        case "bar":
            return "wineglass"
        case "park":
            return "leaf"
        case "museum":
            return "building.columns.fill"
        case "art":
            return "hand.draw.fill"
        case "historic site":
            return "hourglass"
        case "shopping":
            return "bag"
        default:
            return ""
        }
    }
}
