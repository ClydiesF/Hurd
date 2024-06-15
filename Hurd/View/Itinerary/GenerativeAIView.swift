//
//  GenerativeAIView.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/16/24.
//

import SwiftUI
import Foundation
import GoogleGenerativeAI

struct GenerativeAIView: View {
    @StateObject var vm: GenerativeAIViewModel
    @State private var selectedOption = 0 // 0 for Itinerary, 1 for Activities
    @ObservedObject var itinVM: ItineraryViewModel
    @State private var showImportSheet: Bool = false
    
    @State private var activitySwapped: ActivityAI?
    
    // MARK: Generative AI Contentt
    var body: some View {
        ZStack {
            // View 1
            VStack {
                HStack {
                    Text("Generate ")
                    Text("\(selectedOption == 0 ? "Itinerary" : "Activities")")
                        .animation(.easeInOut, value: selectedOption)
                }
                .padding(.top)
                .font(.title)
                .fontWeight(.semibold)
                    
                
                Text("Use Generative AI to generate Activities for your trip automatically.")
                    .font(.caption)
                    .fontWeight(.light)
                    .padding(.horizontal)
                
                // Conditionally render the textfield to accept location
                if vm.location.isEmpty {
                    TextField(text: $vm.location, label: {
                        Text("Location")
                    })
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                }
        
                Picker("Select", selection: $selectedOption) {
                             Text("Itinerary").tag(0)
                             Text("Activities").tag(1)
                         }
                         .pickerStyle(SegmentedPickerStyle())
                         .onChange(of: selectedOption, { oldValue, newValue in
                             if oldValue == 1 {
                                 vm.isFullItinerary = true
                             } else {
                                 vm.isFullItinerary = false
                             }
                         })
                         .padding()

                
                if let days = vm.days, days.isEmpty {
                    HStack(spacing: Spacing.twentyone) {
              
                        DatePicker("Select Day", selection: $vm.selectedDate, displayedComponents: .date)
                            .labelsHidden()
                
                        Text("days")

                        Picker("Number", selection: $vm.selectedNumber) {
                            ForEach(1...vm.maximumNumber, id: \.self) { number in
                            Text("\(number)")
                          }
                        }
                        .frame(minWidth: 50)
                    }
                }
                
                if selectedOption == 0 {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(0 ..< (vm.days?.count ?? 0),id: \.self) { index in
                                if let day = vm.days?[index] {
                                    DateViewAI(date: day, index: index, selectedSegment: $vm.selectedIndex)
                                        .onTapGesture {
                                            vm.selectedIndex = index
                                        }
                                }
                            }
                        }
                        .padding(10)
                    }
                }

                
                Divider()
                
                Spacer()
                // MARK: Show the List here for the activities that will come.
                // Loading View
                if vm.isLoading {
                    LoadingView()
                } else {
                    List {
                        ForEach(vm.returnActivities(), id: \.self) { activity in
                            
                            ActivityViewAI(activity: activity)
                                .swipeActions {
                                    Button("Edit") {
                                        print("DEBUG: pull up import sheet")
                                        activitySwapped = activity
                                        showImportSheet = true
                                        
                                    }
                                    .tint(.purple)
                                }
                        }
                    }
                }
            }
            
            // View 2
            VStack {
                Spacer()
                HStack {
                    Button(action: {
                        print("DEBUG: Call Func to add to ITenirary and change the dates on the trip object")
                    }, label: {
                        Text("Import \(selectedOption == 0 ? "Itinerary" : "Activities")")
                            .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding()
                            .background(Capsule().fill(.white).shadow(color: .gray.opacity(0.2) ,radius: 5))
                            .animation(.easeIn, value: selectedOption)
                    })
                    
                    Spacer()
                    Button(action: {
                        print("DEBUG: Generate AI")
                        vm.isLoading = true
                        Task {
                            await vm.generateItineraries()
                        }
                    }, label: {
                        Image(systemName: "sparkle")
                            .font(.system(size: 30))
                            .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .padding()
                            .background(Circle().fill(.white).shadow(color: .gray.opacity(0.2) ,radius: 5))
                    })
                }
                .padding()
            }
        }
        .sheet(isPresented: $showImportSheet, content: {
            if let activitySwapped , let trip = itinVM.trip {
                importActivityView(itinVM: itinVM, trip: trip, activity: activitySwapped)
            }
            // Provide error screen here as well.
          
        })
    }
    
}

struct LoadingView: View {
  var body: some View {
    VStack {
      ProgressView()
      Text("Loading...")
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color.black.opacity(0.3))
    .foregroundColor(.white)
  }
}


#Preview {
    GenerativeAIView(vm: .init(generativeAIModel: .init(name: "ffdsd", apiKey: "dfsfsd"), trip: Trip.mockTrip), itinVM: ItineraryViewModel.provideMockItineraryViewModel())
}
