//
//  User.swift
//  Hurd
//
//  Created by clydies freeman on 1/10/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User: Codable {
    var id: String?
    let createdAt: Double?
    let isFinishedOnboarding: Bool
    let emailAddress: String?
    let phoneNumber: String?
    let gender: String?
    let ethnicity: String?
    let bio: String
    let firstName: String
    let lastName: String
    var profileImageUrl: String?
    var trips: [String]? // trip ID... reference
    var genderShown: Bool
    var emailShown: Bool
    var phoneNumberShown: Bool
    var ethnicityShown: Bool
}

extension User {
    static let mockUser1 = User(id: "1",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", gender: "he/him", ethnicity: "Black/African - American", bio: "I just want to travel the world and do cool stuff becuase thats the weave and i really lvoer so much, come join me ", firstName: "Todd", lastName: "Trenton", profileImageUrl: "https://picsum.photos/200/300", genderShown: true, emailShown: true, phoneNumberShown: true, ethnicityShown: true)
    
    static let mockUser2 = User(id: "2",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", gender: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", ethnicity: "Clyde", bio: "i think i like to go on long bike rides with my family and thats hwy i travel", firstName: "mockAvatarImage", lastName: "", profileImageUrl: "https://picsum.photos/200/300", genderShown: true, emailShown: true, phoneNumberShown: true, ethnicityShown: true)
    
    static let mockUser3 = User(id: "3",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", gender: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", ethnicity: "Clyde", bio: "gsdklklsdgkl sdgklklsdgklsgd sdglkgsdklmgd dgskdgkd dkdkdd d dkdk dk dklldksksdg sdgl dgs", firstName: "mockAvatarImage",  lastName: "", profileImageUrl: "https://picsum.photos/200/300", genderShown: true, emailShown: true, phoneNumberShown: true, ethnicityShown: true)
    
    static let mockUser4 = User(id: "4",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", gender: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", ethnicity: "Clyde", bio: "kldflnkdfgkl dfgkldfgk dfglkfdg kldfgkldfg klkdfg fkkfkdfg kldfkld sgklkl;sg sdgksksdkl sdgkksmklsdg sdgkl;gsd", firstName: "mockAvatarImage",  lastName: "", profileImageUrl: "https://picsum.photos/200/300", genderShown: true, emailShown: true, phoneNumberShown: true, ethnicityShown: true)
    
    static let mockUser5 = User(id: "5",createdAt: 33424332432, isFinishedOnboarding: true, emailAddress: "c.edward.freeman@gmail.com", phoneNumber: "617-233-1242", gender: "I really like alot of ppl. that i liek to go over the same thing i want to get some money and i like more money than i have mow. lets go!", ethnicity: "Clyde", bio: "Freeman", firstName: "mockAvatarImage",  lastName: "", profileImageUrl: "https://picsum.photos/200/300", genderShown: true, emailShown: true, phoneNumberShown: true, ethnicityShown: true)
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}

struct Trip: Codable {
    @DocumentID var id: String?
    let createdAt: Double?
    var tripName: String
    var tripDestination: String
    var tripType: String
    var tripCostEstimate: Double
    var tripStartDate: Double
    var tripEndDate: Double
    var tripDescription: String?
    var hurd: Hurd?// Reference
    var suggestions: String? // Reference
    var tripImageURLString: UnsplashPhoto?
    //Additional Details of a trip
    var itineraryId: String? // reference
}


struct UnsplashPhoto: Codable {
    var photoURL: String?
    var authorName: String?
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



extension Trip {
    
    
    static let mockTrip = Trip(createdAt: 1688865798, tripName: "Mock Trip", tripDestination: "Boston, MA", tripType: "Cruise", tripCostEstimate: 5600.0,tripStartDate: 329773023, tripEndDate: 3434324233,tripDescription: " I think it makes sense to go on this trip because i love the trip so muich and i like it man, so i am the dude.", hurd: Hurd.mockHurd, tripImageURLString: UnsplashPhoto(photoURL: "https://picsum.photos/200/300", authorName: "Fake Author"))
    
    static let mockTrip2 = Trip(createdAt: 1688865798, tripName: "Mock Trip 2", tripDestination: "Charlotte, NC", tripType: "Adventure", tripCostEstimate: 1577.0,tripStartDate: 329773023, tripEndDate: 3434324233, tripDescription: "i  dont like it becuase this is so scrayx i and i liek that most ppl dont like to travel and i konw thaty mosty ppl will like to tracvel but cant. " ,hurd: Hurd.mockHurd)
    
    static let mockTrip3 = Trip(createdAt: 1688865798, tripName: "Mock Trip 3", tripDestination: "Dallas, TX", tripType: "Road Trip", tripCostEstimate: 7600.0,tripStartDate: 329773023, tripEndDate: 3434324233, hurd: Hurd.mockHurd)
    
    static let mockTrip4 = Trip(createdAt: 1688865798, tripName: "Mock Trip 4", tripDestination: "Houston, TX", tripType: "Vacation", tripCostEstimate: 8600.0,tripStartDate: 329773023, tripEndDate: 3434324233, hurd: Hurd.mockHurd)
    
    static let mockTrip5 = Trip(createdAt: 1688865798, tripName: "Mock Trip 5", tripDestination: "Los Angeles, LA", tripType: "Excursion", tripCostEstimate: 9600.0,tripStartDate: 1711670400, tripEndDate: 1712275200, hurd: Hurd.mockHurd)
    
    static let mockTrip6 = Trip(createdAt: 1688865798, tripName: "Mock Trip 6", tripDestination: "New York City, NY", tripType: "Business", tripCostEstimate: 577.0,tripStartDate: 329773023, tripEndDate: 3434324233, hurd: Hurd.mockHurd)
    
    var tripCostString: String {
        var cost = tripCostEstimate
        
        if tripCostEstimate < 1000 {
            if tripCostEstimate >= 50 {
                cost = round(tripCostEstimate / 50) * 50
            } else {
                cost = round(tripCostEstimate / 100) * 100
            }
        }
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = cost < 1000 ? 0 : 1
        numberFormatter.decimalSeparator = "."
        
        let number = NSNumber(value: cost)
        var result = numberFormatter.string(from: number) ?? ""
        
        if cost >= 1000 {
            cost = round(cost / 100) / 10
            result = String(cost) + "k"
        }
        
        return result
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
    
    var TripDuration: String {
        let start_date = Date(timeIntervalSince1970: self.tripStartDate)
        let end_date = Date(timeIntervalSince1970: self.tripEndDate)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: start_date, to: end_date)
        
        if let day = components.day {
            let stringDuration = String(day)
            return stringDuration
        }
        return "0"
    }
    
    var dateRangeString: String {
        
        let startDate = Date(timeIntervalSince1970: self.tripStartDate)
        let endDate = Date(timeIntervalSince1970: self.tripEndDate)
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM/dd/yy" //Specify your format that you want
        let strDate = dateFormatter.string(from: startDate)
        let eDate = dateFormatter.string(from: endDate)
        
        return "\(strDate) - \(eDate)"
    }
}
