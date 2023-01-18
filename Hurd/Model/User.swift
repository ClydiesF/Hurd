//
//  User.swift
//  Hurd
//
//  Created by clydies freeman on 1/10/23.
//

import Foundation
import FirebaseFirestoreSwift



enum NoteType {
    case important
    case generalNote
    
    var iconString: String {
        switch self {
        case .important:
            return "exclamationmark.triangle.fill"
        case .generalNote:
            return "note.text"
        }
    }
}

struct User: Codable {
    var id: String?
    let createdAt: Double?
    let isFinishedOnboarding: Bool
    let emailAddress: String?
    let phoneNumber: String
    let bio: String
    let firstName: String
    let lastName: String
    var profileImageUrl: String?
    var trips: [String]? // trip ID... reference
}

extension User {
    static let mockUser1 = User(id: "1",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", bio: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", firstName: "Clyde", lastName: "Freeman", profileImageUrl: "mockAvatarImage")
    
    static let mockUser2 = User(id: "2",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", bio: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", firstName: "Clyde", lastName: "Freeman", profileImageUrl: "mockAvatarImage")
    
    static let mockUser3 = User(id: "3",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", bio: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", firstName: "Clyde", lastName: "Freeman", profileImageUrl: "mockAvatarImage")
    
    static let mockUser4 = User(id: "4",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", bio: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", firstName: "Clyde", lastName: "Freeman", profileImageUrl: "mockAvatarImage")
    
    static let mockUser5 = User(id: "5",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", bio: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", firstName: "Clyde", lastName: "Freeman", profileImageUrl: "mockAvatarImage")
}

struct Trip: Codable {
    @DocumentID var id: String?
    var tripName: String
    var tripDestination: String
    var tripType: String
    var tripCostEstimate: Double
    var tripStartDate: Double
    var tripEndDate: Double
    var tripDescription: String?
    var hurd: Hurd?// Reference
    var suggestions: String? // Reference
    //Additional Details of a trip
}

struct TripSuggestions: Codable {
    @DocumentID var id: String?
    let locationSuggestions: [Suggestion]?
    let lodgingSuggestions: [Suggestion]?
    let dateSuggestions: [Suggestion]?
    
}

struct Suggestion: Codable {
    let userId: String
    let Suggestion: String
}

struct DateSuggestion: Codable {
    let userId: String
    let startDate: Double
    let endDate: Double
}

struct Hurd: Codable {
    @DocumentID var id: String?
    var name: String?
    var members: [String]?
    var organizer: String
    var hurdID: String?
}

extension Hurd {
    static let mockHurd = Hurd(organizer: "vwefwevewewe")
}

extension Trip {
    static let mockTrip = Trip(tripName: "Mock Trip", tripDestination: "Boston, MA", tripType: "Cruise", tripCostEstimate: 5600.0,tripStartDate: 329773023, tripEndDate: 3434324233, hurd: Hurd.mockHurd)
    
    static let mockTrip2 = Trip(tripName: "Mock Trip 2", tripDestination: "Charlotte, NC", tripType: "Adventure", tripCostEstimate: 600.0,tripStartDate: 329773023, tripEndDate: 3434324233, tripDescription: "i  dont like it becuase this is so scrayx i and i liek that most ppl dont like to travel and i konw thaty mosty ppl will like to tracvel but cant. " ,hurd: Hurd.mockHurd)
    
    static let mockTrip3 = Trip(tripName: "Mock Trip 3", tripDestination: "Dallas, TX", tripType: "Road Trip", tripCostEstimate: 7600.0,tripStartDate: 329773023, tripEndDate: 3434324233, hurd: Hurd.mockHurd)
    
    static let mockTrip4 = Trip(tripName: "Mock Trip 4", tripDestination: "Houston, TX", tripType: "Vacation", tripCostEstimate: 8600.0,tripStartDate: 329773023, tripEndDate: 3434324233, hurd: Hurd.mockHurd)
    
    static let mockTrip5 = Trip(tripName: "Mock Trip 5", tripDestination: "Los Angeles, LA", tripType: "Excursion", tripCostEstimate: 9600.0,tripStartDate: 329773023, tripEndDate: 3434324233, hurd: Hurd.mockHurd)
    
    static let mockTrip6 = Trip(tripName: "Mock Trip 6", tripDestination: "New York City, NY", tripType: "Business", tripCostEstimate: 500.0,tripStartDate: 329773023, tripEndDate: 3434324233, hurd: Hurd.mockHurd)
    
    var tripCostString: String {
        return String(format: "%.02f", self.tripCostEstimate)
    }
    
    var iconName: String {
        switch self.tripType {
        case "Vacation":
            return "beach.umbrella"
        case "Cruise":
            return "sailboat.fill"
        case "Road Trip":
            return "car.fill"
        case "Excursion":
            return "figure.play"
        case "Adventure":
            return "figure.hiking"
        case "Business":
            return "suitcase.fill"
        default:
            return ""
            
        }
    }
    
    var dateRangeString: String {
        
        let startDate = Date(timeIntervalSince1970: self.tripStartDate)
        let endDate = Date(timeIntervalSince1970: self.tripEndDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd/yy" //Specify your format that you want
        let strDate = dateFormatter.string(from: startDate)
        let eDate = dateFormatter.string(from: endDate)
        
        return "\(strDate) - \(eDate)"
    }
}
