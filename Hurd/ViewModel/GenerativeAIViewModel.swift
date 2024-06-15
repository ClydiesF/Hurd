//
//  GenerativeAIViewModel.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/19/24.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI


@MainActor
class GenerativeAIViewModel: ObservableObject {
    @Published var location = ""
    @Published var selectedDate: Date = Date()
    @Published var selectedNumber: Int = 1
    @Published var isLoading = false
    @Published var activities: [ActivityAI]?
    @Published var days: [Date]?
    @Published var selectedIndex = 0
    let maximumNumber: Int = 3
    var tripID: String?
    var isFullItinerary = true
    var trip: Trip?

    private let generativeAIModel: GenerativeModel

    init(generativeAIModel: GenerativeModel, location: String = "", tripID: String? = nil, days: [Date]? = nil, trip: Trip?) {
        self.generativeAIModel = generativeAIModel
        self.location = location
        self.tripID = tripID
        self.days = days
        self.trip = trip
    }

    func generateItineraries() async {
        isLoading = true
        defer { isLoading = false }

        let prompt = createPrompt()
        do {
            let response = try await generativeAIModel.generateContent(prompt)
            processResponse(response)
            
        } catch(let error) {
            // Handle error
        print("DEBUG: Issue Generating results from prompt --- \(error).")
        }
    }
    
    // Replace an existing itineerary if there is one. and changes the date. this is only good for weekend trips as token capacity is limited.
    private func importItinerary() {
        // This needs to be a bulk upload!
        guard let itineraryId = trip?.itineraryId,
              let activities else { return }
        
        for activity in activities {
            do {
                try ITINERARY_REF.document(itineraryId).collection("Activities").addDocument(from: activity)
            } catch {
                // hnadle error here
                print("DEBUG: Some error was encountered uploading the data to Firebase.")
            }
        }
        self.activities = nil
    }

    private func createPrompt() -> String {
        // determine wether to make multiple calls if more than 3 days.
        if !isFullItinerary {
            // perform activites requqest
            return PromptModels.getActivities(location: location)
            
        } else {
            // perform normal request
            if let startdate = trip?.tripStartDate {
                return PromptModels.getItineries(location: location, days: 3, startDate: startdate)
            }
            return ""
        }
    }

    func createDateRanges(from dates: [Date]) -> [String] {
        // Sort the dates to ensure correct order
        let sortedDates = dates.sorted()

        // Create a DateFormatter to output the desired string format
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy" // Customize format if needed

        // Initialize an empty array to store the date range strings
        var dateRangeStrings: [String] = []

        // Iterate through the sorted dates
        for (index, date) in sortedDates.enumerated() {
            // Calculate the end date (3 days from the current date)
            guard let endDate = Calendar.current.date(byAdding: .day, value: 3, to: date) else { continue }

            // If it's the first date, or the current group's end date is earlier than the previous start...
            if index == 0 ||
                Calendar.current.compare(date, to: dateFormatter.date(from: dateRangeStrings.last!.components(separatedBy: " - ")[0]) ?? Date(), toGranularity: .day) != .orderedSame {
                // ...start a new date range string
                dateRangeStrings.append("\(dateFormatter.string(from: date)) - \(dateFormatter.string(from: endDate))")
            } else {
                // ...otherwise, update the end date of the last existing range
                dateRangeStrings[dateRangeStrings.count - 1] = "\(dateRangeStrings.last!.components(separatedBy: " - ")[0]) - \(dateFormatter.string(from: endDate))"
            }
        }

        return dateRangeStrings
    }

    private func processResponse(_ response: GenerateContentResponse) {
        // ... parse response, update states (days, activities) using dateHelper
        guard let text = response.text,
              let editedText = text.remove(word: "json"),
              let editedTextNoBacticks = editedText.remove(word: "```"),
              let data = editedTextNoBacticks.data(using: .utf8),
              let activities = decodeActivities(jsonData: data) else { return }
        
        print("DEBUG: response --> \(editedTextNoBacticks)")
       // self.days = selectedDate.get_date_range(for: selectedNumber) // get_date_range(startDate: selectedDate, numOfDays: selectedNumber)
        self.activities = activities
    }
    
    func decodeActivities(jsonData: Data) -> [ActivityAI]? {
      let decoder = JSONDecoder()
      do {
        return try decoder.decode([ActivityAI].self, from: jsonData)
      } catch {
        print("Error decoding JSON: \(error)")
        return nil
      }
    }

    func returnActivities() -> [ActivityAI] {
        guard let activities else { return [] }
        
        if isFullItinerary {
            let filterActivities = activities.filter({ act in
                if let selectedDate = days?[selectedIndex] {
                    return act.dateComponents == selectedDate.monthDay
                }
                return false
            })
            
            return filterActivities
        } 
        
        return activities
    }
}
