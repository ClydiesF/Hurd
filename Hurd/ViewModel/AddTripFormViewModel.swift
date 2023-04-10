//
//  AddTripFormViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/12/23.
//

import Foundation
import SwiftUI
import MapKit
import Combine
import Firebase
import Alamofire

class AddTripFormViewModel: NSObject, ObservableObject {
    
    let accessKey = "OQ56zpALUrsgNX0WDbMccCIsZ1CUDT9fD1skJIUhrY8"
    @Published var tripNameText: String = ""
    @Published var tripDescriptionText: String = ""
    @Published var tripLocationSearchQuery: String = ""
    @Published var tripCostEstimate: Double = 0
    
    @Published private(set) var status: SearchStatus = .idle
    @Published private(set) var locationStatus: LocationStatus = .notSelected
    @Published private(set) var searchResults: [MKLocalSearchCompletion] = []
    @Published var tripStartDate = Date.now
    @Published var tripEndDate: Date = Date.now
    
    @Published var selectedTripType: String = ""
    @Published var selectedGender: String = ""
    
    @Published var formType: FormType = .add
    
    @Published var addTripFormPresented: Bool = false
    var tripPhoto: String?
    var tripPhotoAuthor: String?
    
    var fieldsArePopulated: Bool {
        !tripNameText.isEmpty && !tripLocationSearchQuery.isEmpty && !selectedTripType.isEmpty && !tripDescriptionText.isEmpty && !tripCostEstimate.isZero
    }
    
    var currentEditableTripId: String?

    private var queryCancellable: AnyCancellable?
    private let searchCompleter: MKLocalSearchCompleter!
    
    enum FormType {
        case add
        case edit
    }
    
    enum SearchStatus: Equatable {
        case idle
        case noResults
        case isSearching
        case error(String)
        case result
    }
    
    enum LocationStatus {
        case notSelected
        case selected
    }
    
    enum TripType: String {
        case vacation
        case cruise
        case roadTrip = "road trip"
        case adventure
        case business
        case excursion
        case none = ""
    }
    
   
    var tripTypes: [String] = ["","Vacation", "Cruise", "Road Trip", "Adventure", "Business", "Excursion"]
    
    init(searchCompleter: MKLocalSearchCompleter = MKLocalSearchCompleter()) {
        self.searchCompleter = searchCompleter
        super.init()
        self.searchCompleter.delegate = self

        queryCancellable = $tripLocationSearchQuery
            .receive(on: DispatchQueue.main)
            // we're debouncing the search, because the search completer is rate limited.
            // feel free to play with the proper value here
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main, options: nil)
            .sink(receiveValue: { fragment in
                self.status = .isSearching
                if !fragment.isEmpty {
                    self.searchCompleter.queryFragment = fragment
                } else {
                    self.status = .idle
                    self.searchResults = []
                }
        })
    }
    func selectedLocation(_ location: MKLocalSearchCompletion) {
        self.status = .idle
        self.locationStatus = .selected
        self.tripLocationSearchQuery = "\(location.title), \(location.subtitle)"
    }
    
    func resetFormValues() {
        self.tripDescriptionText = ""
        self.tripNameText = ""
        self.tripStartDate = Date()
        self.tripEndDate = Date()
        self.tripLocationSearchQuery = ""
        self.tripCostEstimate = 0
        self.selectedTripType = TripType.none.rawValue
    }
    
    func prepopulateValuesFrom(current trip: Trip) {
        self.currentEditableTripId = trip.id
        self.formType = .edit
        self.tripDescriptionText = trip.tripDescription ?? ""
        self.tripNameText = trip.tripName
        self.tripStartDate = Date(timeIntervalSince1970: trip.tripStartDate)
        self.tripEndDate = Date(timeIntervalSince1970: trip.tripEndDate)
        self.tripLocationSearchQuery = trip.tripDestination
        self.tripCostEstimate = trip.tripCostEstimate
        self.selectedTripType = trip.tripType
    }
    
    func editTrip() {
        guard let tripId = self.currentEditableTripId else { return }
        
        let editedTrip = Trip(tripName: self.tripNameText,
                              tripDestination: self.tripLocationSearchQuery,
                              tripType: self.selectedTripType,
                              tripCostEstimate: self.tripCostEstimate,
                              tripStartDate: self.tripStartDate.timeIntervalSince1970,
                              tripEndDate: self.tripEndDate.timeIntervalSince1970,
                              tripDescription: self.tripDescriptionText == "" ? nil: self.tripDescriptionText )
        do {
            try TRIP_REF.document(tripId).setData(from: editedTrip,merge: true)
        } catch(let err) {
            print("DEBUG: err \(err.localizedDescription)")
        }
    }
    
    func fetchLocationImage() async {
        AF.request("https://api.unsplash.com/search/photos/?client_id=\(accessKey)&query=\(tripLocationSearchQuery)").responseDecodable(of: UnSplashResponseModel.self) { response in
            
            switch response.result {
            case .success(let res):
                let upperLimit = (res.results.count) - 1
                let index = Int.random(in: 0...upperLimit)
                print("DEBUG: image-> success \(res.results[index].urls.regular)")
                self.tripPhoto = "\(res.results[index].urls.regular)"
                self.tripPhotoAuthor =  "\(res.results[index].user.name)"
//                return UnsplashPhoto(photoURL: tripPhoto, authorName: tripPhotoAuthor)
            case .failure(let err):
                print("DEBUG: image ->err \(err)")
//                return nil
            }
        }
    }
    
    func postTrip() async {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        var newHurd = Hurd(organizer: userId)
        var tripString = tripLocationSearchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let comma: Set<Character> = [" "]
        tripString.removeAll(where: { comma.contains($0) })
        print("DEBUG: Trip String", tripString)
        
        AF.request("https://api.unsplash.com/search/photos/?client_id=\(accessKey)&query=\(tripString)").responseDecodable(of: UnSplashResponseModel.self) { response in
            
            switch response.result {
            case .success(let res):
                let upperLimit = (res.results.count) - 1
                if upperLimit > 0 {
                    let index = Int.random(in: 0...upperLimit)
                    print("DEBUG: image-> success \(res.results[index].urls.regular)")
                    self.tripPhoto = "\(res.results[index].urls.regular)"
                    self.tripPhotoAuthor =  "\(res.results[index].user.name)"
                } else {
                    self.tripPhoto = "\(res.results[0].urls.regular)"
                    self.tripPhotoAuthor =  "\(res.results[0].user.name)"
                }
                
                do {
                    let ref = try HURD_REF.addDocument(from: newHurd)
                    newHurd.hurdID = ref.documentID
                    print("DEBUG: difernece in UID's \(newHurd.id) - \(ref) ")
                    
                    let photoInfo = UnsplashPhoto(photoURL: self.tripPhoto, authorName: self.tripPhotoAuthor)
                    
                    let newTrip = Trip(tripName: self.tripNameText, tripDestination: self.tripLocationSearchQuery, tripType: self.selectedTripType, tripCostEstimate: self.tripCostEstimate, tripStartDate: self.tripStartDate.timeIntervalSince1970, tripEndDate: self.tripEndDate.timeIntervalSince1970, tripDescription: self.tripDescriptionText, hurd: newHurd, tripImageURLString: photoInfo)
                    try TRIP_REF.document().setData(from: newTrip)
                    
                    self.tripNameText = ""
                    self.tripDescriptionText = ""
                    self.tripLocationSearchQuery  = ""
                    self.tripCostEstimate = 0
                    
                    self.status = .idle
                    self.tripStartDate = Date.now
                    self.tripEndDate = Date.now
                    
                    self.selectedTripType = ""
                    self.searchResults = []
                    self.locationStatus = .notSelected
                } catch(let err) {
                    print("DEBUG: err \(err.localizedDescription)")
                }
            case .failure(let err):
                print("DEBUG: image ->err \(err)")
//                return nil
            }
            
        }
        
        

    }
}

extension AddTripFormViewModel: MKLocalSearchCompleterDelegate {
    
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.searchResults = completer.results//.filter({ $0.subtitle == "" })
        self.status = completer.results.isEmpty ? .noResults : .result
    }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        self.status = .error(error.localizedDescription)
    }
}
