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

class AddTripFormViewModel: NSObject, ObservableObject {
    @Published var tripNameText: String = ""
    @Published var tripDescriptionText: String = ""
    @Published var tripLocationSearchQuery: String = ""
    @Published var tripCostEstimate: Double = 0
    
    @Published private(set) var status: SearchStatus = .idle
    @Published private(set) var searchResults: [MKLocalSearchCompletion] = []
    @Published var tripStartDate = Date.now
    @Published var tripEndDate: Date = Date.now
    
    @Published var selectedTripType: String = ""

    private var queryCancellable: AnyCancellable?
    private let searchCompleter: MKLocalSearchCompleter!
    
    enum SearchStatus: Equatable {
        case idle
        case noResults
        case isSearching
        case error(String)
        case result
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
    func selectedLocation() {
        self.status = .idle
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
