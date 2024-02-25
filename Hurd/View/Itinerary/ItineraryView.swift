//
//  ItineraryView.swift
//  HurdTravel
//
//  Created by clydies freeman on 1/26/24.
//

import SwiftUI

struct ItineraryView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var openActivityAddSheet: Bool = false
    @State var openGenerativeAISheet: Bool = false
    @State var selectedSegment: Int = 0
    @State var type = ActivityFormType.add
    @State var swappedActivity: Activity?
    
    @ObservedObject var vm: ItineraryViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(vm.trip?.tripName ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                
                if let activitiesCount = vm.activities?.count {
                    Text("\(activitiesCount)")
                        .BadgeStyle()
                }
                Spacer()
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal,showsIndicators: false) {
                HStack {
                    ForEach(0 ..< (vm.daysInItinerary?.count ?? 0), id: \.self) { index in
                        if let daysInItinerary = vm.daysInItinerary {
                            DateView(date: daysInItinerary[index], index: index, selectedSegment: $selectedSegment)
                                .onTapGesture {
                                    selectedSegment = index
                                }
                        }
                    }
                }
                .padding(.leading)
                .padding(.bottom, 10)
            }
            Divider()
            
            //TODO: Enter Content HERE.. This should be a list.
            
            // vm.trips.filter { ($0.tripEndDate + 86400) >= vm.currentDate
            List {
                // List the activities for the selected Day
                ForEach(returnActivitiesForDay(), id: \.self) { act in
                    ActivityView(activity: act)
                        .swipeActions {
                            // TODO: only allow the user of the activity to edit.
                            Button("Delete") {
                                print("DEBUG: Delete this item")
                                _ = vm.performAction(for: .delete, activity: act)
                            }
                            .tint(.red)
                            
                            Button("Edit") {
                                self.type = .edit
                                self.swappedActivity = act
                                openActivityAddSheet = true
                                print("DEBUG: Edit this item")
                            }
                            .tint(.orange)
                        }
                }
            }
            .overlay {
                if returnActivitiesForDay().isEmpty {
                    VStack {
                        NoActivityView(shouldShowAlert: $openActivityAddSheet, type: $type, swappedActivity: $swappedActivity)
                        Spacer()
                    }
                    .padding(.top, Spacing.twentyfour)
                }
            }
            Spacer()
        }
        .sheet(isPresented: $openGenerativeAISheet, content: {
            GenerativeAIView(vm: .init(generativeAIModel: .init(name: "gemini-pro", apiKey: "AIzaSyDFtU_plljqSmc-IQLLIAWs3sq1xfynPlQ"),location: vm.trip?.tripDestination ?? "", tripID: vm.tripId, days: vm.daysInItinerary ))
                .padding(.horizontal)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        })
        .sheet(isPresented: $openActivityAddSheet, content: {
            ActivityFormView(vm: vm, trip: vm.trip!, activity: swappedActivity, activityFormType: type)
                .padding(.horizontal)
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
        })
        .onAppear(perform: {
            vm.datesBetween()
            print("DEBUG: Dont need to call anything! Right now. ")
        })
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button {
                        // pull up sheet
                        print("DEBUG: Pull Generative AI Sheet")
                        openGenerativeAISheet = true
                    } label: {
                        Image(systemName: "sparkle")
                            .foregroundStyle( LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                            .fontWeight(.semibold)
                    }
                    Button(action: {
                        type = .add
                        swappedActivity = nil
                        openActivityAddSheet = true
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
                            .fontWeight(.semibold)
                    })

                }
    
            }
            
            ToolbarItem(placement: .topBarLeading) {
                Button(action: { presentationMode.wrappedValue.dismiss() }, label: {
                    Image(systemName: "chevron.left.circle.fill")
                        .foregroundColor(.black)
                        .fontWeight(.semibold)
                })
            }
        }
    }
    
    // METHODS:
    func returnActivitiesForDay() -> [Activity] {
        guard let activities = vm.activities?.filter({ act in
            if let selectedDate = vm.daysInItinerary?[selectedSegment] {
                return act.dateComponents == selectedDate.monthDayYear
            }
            return false
        }) else { return [] }
        
        return activities
    }
}

#Preview {
    ItineraryView(vm: ItineraryViewModel.provideMockItineraryViewModel())
}
