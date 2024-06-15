//
//  importActivityView.swift
//  HurdTravel
//
//  Created by clydies freeman on 3/9/24.
//

import SwiftUI
import FirebaseAuth

struct importActivityView: View {
    @State var withoutEditing: Bool = false
    @Environment(\.presentationMode) var presentationMode
    
    @State var hourSelection: Int = 0
    @State var minuteSelection: Int = 0
    @State var selectedStartDate: Date = Date.now
    @ObservedObject var itinVM: ItineraryViewModel
    
    var trip: Trip
    var activity: ActivityAI
    
    var body: some View {
        VStack {
        Text("Import Activity")
                .font(.title3)
                .fontWeight(.semibold)
            
            Toggle("import without Editing", isOn: $withoutEditing)
            Text("Activity will apear in the Itiinerary view, in the Activities segment. Here you can assing the activity to your actual itinerary")
                .font(.caption)
                .foregroundStyle(.gray.opacity(0.7))
            
           
            /// Date, Time, Duration
           DatePicker("Start", selection: $selectedStartDate, in: createDateRange())
            
            Text("Activity Duration")
            CustomDatePicker(hourSelection: $hourSelection, minuteSelection: $minuteSelection)
                .frame(height: 200)
            
            Button("import") {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                let intNumber = Double(selectedStartDate.timeIntervalSince1970)
                
                let activity = Activity(type: activity.type,
                                        name: activity.name,
                                        location: activity.location,
                                        description: activity.description,
                                        link: activity.link,
                                        status: "confirmed",
                                        startTime: withoutEditing ? nil : intNumber,
                                        durationHours: withoutEditing ? nil : hourSelection,
                                        durationMinutes: withoutEditing ? nil : minuteSelection,
                                        author: userId)
                //activity.id = self.activity.id
                
                if itinVM.performAction(for: .add, activity: activity) {
                    //showSuccessStatusMessage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                          presentationMode.wrappedValue.dismiss()
                      }
                } else {
                    //showErrorStatusMessage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                          presentationMode.wrappedValue.dismiss()
                      }
                }
            
                print("DEBUG: import Activity")
            }
            
            Spacer()
        }
        .padding()
    }
    
    // MARK: methods
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
    importActivityView(itinVM: ItineraryViewModel.provideMockItineraryViewModel(), trip: Trip.mockTrip, activity: ActivityAI.mockActivityAI)
}
