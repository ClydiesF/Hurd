//
//  ActivityFormView.swift
//  HurdTravel
//
//  Created by clydies freeman on 1/28/24.
//

import SwiftUI
import FirebaseAuth

enum ActivityFormType {
    case edit
    case add
    case delete
}

struct ActivityFormView: View {
    @State var name: String = ""
    @State var description: String = ""
    @State var location: String = ""
    @State var activityLink: String = ""
    @State var activityType: String = ""
    
    @State var selectedStartDate: Date = Date.now
    
    @State var hourSelection: Int = 0
    @State var minuteSelection: Int = 0
    
    @ObservedObject var vm: ItineraryViewModel
    
    var trip: Trip
    var activity: Activity? = nil
    
    let activityFormType: ActivityFormType
    
    let activityTypes = ["other",
                         "returning/Leaving Flight",
                         "transportation",
                         "food",
                         "bar",
                         "movie",
                         "club",
                         "culture",
                         "outdoor",
                         "sports",
                         "educational",
                         "health / wellness"]
    
    
    var body: some View {
        Form {
            Picker("Activity Type", selection: $activityType) {
                ForEach(activityTypes, id: \.self) { Text($0) }
            }
            
            // Have a different case for flight info
            
            Section("Info") {
                TextField("name", text: $name)
                TextField("location", text: $location)
                DatePicker("Start", selection: $selectedStartDate, in: createDateRange())
                CustomDatePicker(hourSelection: $hourSelection, minuteSelection: $minuteSelection)
            }
            
            Section {
                TextEditor(text: $description)
                    .frame(height: 60)
            } header: {
                Text("Description")
            }
            
            
            Section("Additonal Info") {
                TextField("Activity Link", text: $activityLink)
            }
            
            Button(activityFormType == .add ? "Add Activity" : "Edit Activity") {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                let intNumber = Double(selectedStartDate.timeIntervalSince1970)
                
                let activity = Activity(type: activityType,
                                        name: name,
                                        location: location,
                                        description: description,
                                        link: activityLink,
                                        status: "confirmed",
                                        startTime: intNumber,
                                        durationHours: hourSelection,
                                        durationMinutes: minuteSelection,
                                        author: userId)
                
                vm.performAction(for: activityFormType, activity: activity)
                print("DEBUG: Add Activity")
            }
        }
        .onAppear(perform: {
            if activityFormType == .edit {
                prepopulate()
            }
        })
    }
    
    func prepopulate() {
        if let activity {
            let timeInterval = TimeInterval(floatLiteral: activity.startTime)
            let date = Date(timeIntervalSince1970: timeInterval)
            
            name = activity.name
            description = activity.description ?? ""
            location = activity.location ?? ""
            activityLink = activity.link ?? ""
            activityType = activity.type
            selectedStartDate = date
            hourSelection = activity.durationHours ?? 0
            minuteSelection = activity.durationMinutes ?? 0
        }
    }
    
    func createDateRange() -> ClosedRange<Date> {
        let calendar = Calendar.current
        
        let start = Date(timeIntervalSince1970: trip.tripStartDate)
        let end = Date(timeIntervalSince1970: trip.tripEndDate)
        let startComponents = calendar.dateComponents([.year, .month, .day], from: start)
        let endComponents = calendar.dateComponents([.year, .month, .day], from: end)

        return calendar.date(from:startComponents)!
        ...
        calendar.date(from:endComponents)!
    }
}

#Preview {
    ActivityFormView(vm: ItineraryViewModel(itinerary: Itinerary.mockItinerary, tripId: "uweibewife"), trip: Trip.mockTrip, activityFormType: .add)
}
