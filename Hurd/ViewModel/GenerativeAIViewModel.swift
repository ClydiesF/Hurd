//
//  GenerativeAIViewModel.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/19/24.
//

import Foundation
import SwiftUI
import GoogleGenerativeAI

//protocol GenerativeAIModelProtocol {
//    func generateContent(_ prompt: String) async throws -> GenerativeAIResponse?
//}
//
//// For testing
//class MockGenerativeAIModel: GenerativeAIModelProtocol {
//    func generateContent(_ prompt: String) async throws -> GenerativeAIResponse? {
//        // Return test data during testing
//        return ...
//    }
//}

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

    private let generativeAIModel: GenerativeModel

    init(generativeAIModel: GenerativeModel, location: String = "", tripID: String? = nil, days: [Date]? = nil) {
        self.generativeAIModel = generativeAIModel
        self.location = location
        self.tripID = tripID
        self.days = days
    }

    func generateItineraries() async {
        isLoading = true
        defer { isLoading = false }

        let prompt = createPrompt()
        do {
            let response = try await generativeAIModel.generateContent(prompt)
            processResponse(response)
            
        } catch {
            // Handle error
        }
    }
    
    // Replace an existing itineerary if there is one. and changes the date. this is only good for weekend trips as token capacity is limited.
    private func importItinerary() {
        
    }

    private func createPrompt() -> String {
        // determine wether to make multiple calls if more than 3 days.
        PromptModels.getItineries(location: location, days: selectedNumber, startDate: selectedDate.timeIntervalSince1970)
    }

    private func processResponse(_ response: GenerateContentResponse) {
        // ... parse response, update states (days, activities) using dateHelper
        guard let text = response.text,
              let editedText = text.remove(word: "json"),
              let editedTextNoBacticks = editedText.remove(word: "```"),
              let data = editedTextNoBacticks.data(using: .utf8),
              let activities = decodeActivities(jsonData: data) else { return }
        
        print("DEBUG: response --> \(text)")
        self.days = selectedDate.get_date_range(for: selectedNumber) // get_date_range(startDate: selectedDate, numOfDays: selectedNumber)
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

    func returnActivitiesForDay() -> [ActivityAI] {
        guard let activities = activities?.filter({ act in
            if let selectedDate = days?[selectedIndex] {
                return act.dateComponents == selectedDate.monthDay
            }
            return false
        }) else { return [] }
        
        return activities
    }
}

//struct GenerativeAIView: View {
//    @StateObject private var viewModel = GenerativeAIViewModel()
//
//    // ... Your view code, interacting with viewModel properties ...
//
//    Button(action: {
//        viewModel.generateItineraries()
//    }, label: { ... })
//}
