//
//  ItineraryViewModel.swift
//  HurdTravel
//
//  Created by clydies freeman on 1/27/24.
//

import Foundation
import FirebaseAuth

class ItineraryViewModel : ObservableObject {
    let tripId: String
    @Published var trip: Trip?
    @Published var activities: [Activity]?
    @Published var itinarary: Itinerary
    @Published var daysInItinerary: [Date]?
    
    
    init(itinerary: Itinerary, tripId: String) {
        self.tripId = tripId
        self.itinarary = itinerary
        
        Task {
           await fetchTrip(with: tripId)
            fetchActivities()
        }
    }
    
    func fetchTrip(with id: String) async {
        do {
            let tripDoc = try await TRIP_REF.document(id).getDocument()
            let trip =  try tripDoc.data(as: Trip.self)
            print("DEBUG: trip: \(trip)")
            self.trip = trip
            self.datesBetween()
            
        } catch(let err) {
            print("DEBUG: error: \(err.localizedDescription)")
            self.trip = nil
        }
    }
    
    func performAction(for type: ActivityFormType, activity: Activity) {
        guard let userID = Auth.auth().currentUser?.uid,
              let itineraryId = self.itinarary.id  else { return }
        do {
            switch type {
            case .edit:
                if let activityId = activity.id {
                    try ITINERARY_REF.document(itineraryId).collection("Activities").document(activityId).setData(from: activity)
                }
            case .add:
                try ITINERARY_REF.document(itineraryId).collection("Activities").addDocument(from: activity)
                activities?.append(activity)
            case .delete:
                if let activityId = activity.id {
                    ITINERARY_REF.document(itineraryId).collection("Activities").document(activityId).delete()
                }
            }
            
        } catch {
            print("DEBUG: Error Performing action for type: \(type): \(error)")
        }
        
    }
    
    func fetchActivities() {
        guard let itineraryId = self.itinarary.id else { return }
        
        ITINERARY_REF.document(itineraryId).collection("Activities").addSnapshotListener { snapshot, err in
            if let err = err  {
                print("DEBUG: \(err.localizedDescription)")
                return
            }
            
            guard let docs = snapshot?.documents else {
                print("DEBUG: error fetching activites -- no Docs")
                return
            }
            
            let activities = docs.compactMap { doc in
                let result = Result { try doc.data(as: Activity.self) }
                
                switch result {
                case .success(let activity):
                    //self.errorMessage = nil
                    
                    return activity
                case .failure(let err):
                    switch err {
                    case DecodingError.typeMismatch(_, let context):
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.valueNotFound(_, let context):
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.keyNotFound(_, let context):
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    case DecodingError.dataCorrupted(let key):
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    default:
                        print("DEBUG: err getting docs- \(err.localizedDescription)")
                    }
                    return nil
                }
            }
            print("DEBUG: activities - \(activities)")
            self.activities = activities
        }
    }
    func format(date: Date?) -> String {
        guard let date else { return "" }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d - E"//"MMM d, yy - E"
        return dateFormatter.string(from: date)
    }
    
    func datesBetween() {
        guard let startDouble = trip?.tripStartDate, let endDouble = trip?.tripEndDate else { return }
        
        let startDate = Date(timeIntervalSince1970: startDouble)
        let endDate = Date(timeIntervalSince1970: endDouble)
        
        // Ensure startDate is earlier than or equal to endDate
        if startDate > endDate {
            return
        }

        let calendar = Calendar.current
        var dates: [Date] = []

        var currentDate = startDate
        while currentDate <= endDate {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        self.daysInItinerary = dates
    }
}

extension ItineraryViewModel {
   static func provideMockItineraryViewModel() -> ItineraryViewModel {
        let itVm = ItineraryViewModel(itinerary: Itinerary.mockItinerary, tripId: "12345")
        itVm.trip = Trip.mockTrip4
        return itVm
    }
}


