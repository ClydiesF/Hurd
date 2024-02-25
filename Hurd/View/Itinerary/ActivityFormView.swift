//
//  ActivityFormView.swift
//  HurdTravel
//
//  Created by clydies freeman on 1/28/24.
//

import SwiftUI
import FirebaseAuth
import PopupView

enum ActivityFormType {
    case edit
    case add
    case delete
}

struct ActivityFormView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var name: String = ""
    
    @State var showSuccessStatusMessage: Bool = false
    @State var showErrorStatusMessage: Bool = false
    
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
                         "health / wellness",
                         "park",
                         "museum",
                         "art",
                         "historic site",
                         "shopping",
                         
    ]
    
    
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
            
            Button(activityFormType == .add ? "Add Activity" : "Save Changes") {
                guard let userId = Auth.auth().currentUser?.uid else { return }
                let intNumber = Double(selectedStartDate.timeIntervalSince1970)
                
                var activity = Activity(type: activityType,
                                        name: name,
                                        location: location,
                                        description: description,
                                        link: activityLink,
                                        status: "confirmed",
                                        startTime: intNumber,
                                        durationHours: hourSelection,
                                        durationMinutes: minuteSelection,
                                        author: userId)
                activity.id = self.activity?.id
                
                if vm.performAction(for: activityFormType, activity: activity) {
                    showSuccessStatusMessage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                          presentationMode.wrappedValue.dismiss()
                      }
                } else {
                    showErrorStatusMessage = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                          presentationMode.wrappedValue.dismiss()
                      }
                }
            
                print("DEBUG: Add Activity")
            }
        }
        .popup(isPresented: $showSuccessStatusMessage) {
                Text("Sucess!")
                    .frame(width: 200, height: 60)
                    .background(Color(red: 0.85, green: 0.8, blue: 0.95))
                    .cornerRadius(30.0)
            } customize: {
                $0.autohideIn(2)
                    .type(.floater())
                    .position(.top)
                    .animation(.spring())
                    .closeOnTapOutside(true)
//                    .backgroundColor(.black.opacity(0.5))
            }
            .popup(isPresented: $showErrorStatusMessage) {
                VStack {
                    Text("Error!")
                    Text("Error adding or editing trip , Please Trip!")
                        .font(.headline)
                        .foregroundStyle(.gray.opacity(0.4))
                }
                .frame(width: 200, height: 60)
                .background(RoundedRectangle(cornerRadius: 15).fill(.red.opacity(0.4)))
                
                } customize: {
                    $0.autohideIn(2)
                        .type(.floater())
                        .position(.top)
                        .animation(.spring())
                        .closeOnTapOutside(true)
    //                    .backgroundColor(.black.opacity(0.5))
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
