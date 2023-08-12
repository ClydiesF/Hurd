//
//  TripPreviewView.swift
//  Hurd
//
//  Created by clydies freeman on 12/29/22.
//

import SwiftUI
import Kingfisher

struct TripPreviewView: View {
    
    @Binding var isPastTrip: Bool
    var trip: Trip
    var user: User?
    @State var countDownString = ""
    @State var isHorizontal = true
    
    
    var body: some View {
        let layout = isHorizontal ? AnyLayout(HStackLayout(alignment: .bottom)): AnyLayout(VStackLayout(alignment: .leading))
        
        HStack {
            AsyncImage(url: URL(string: "https://picsum.photos/200/300"), content: { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }, placeholder: {
                ProgressView()
            })
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Trip Name")
                        .font(.system(size: 15))
                        .fontWeight(.semibold)
                    
                    Text("Location")
                        .font(.system(size: 13))
                        .foregroundColor(.gray)
                    
                    HStack(alignment: .bottom) {
                        layout {
                            Text(trip.dateRangeString)
                                .font(.system(size: 13))
                                .foregroundColor(.gray)
                            
                            Text("8")
                                .foregroundColor(.white)
                                .fontWeight(.semibold)
                                .font(.system(size: 13))
                                .padding(8)
                                .background(Circle().fill(.black.gradient))
                        }
                       
                        Spacer()
                        Image(systemName: trip.iconName)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .font(.system(size: 13))
                            .padding(8)
                            .background(Circle().fill(.black.gradient))
                    }
            
                        
                    
                }
                .padding(10)
                .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.3)))
 
            }
      
        }
        .frame(height: 100)
       
    }
        
        var timer: Timer {
            Timer.scheduledTimer(withTimeInterval: 60, repeats: true) {_ in
                self.countDownString = countDownString(from: Date())
            }
        }
        
        func countDownString(from date: Date) -> String {
            
            let startDate = Date(timeIntervalSince1970: trip.tripStartDate)
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar
                .dateComponents([.day, .hour, .minute],
                                from: date,
                                to: startDate)
            return String(format: "%02dd",
                          components.day ?? 00)
        }
        
    }
    
    struct TripPreviewView_Previews: PreviewProvider {
        static var previews: some View {
                TripPreviewView(isPastTrip: .constant(false), trip: Trip.mockTrip4)
                    .padding()
        }
    }
    
//        .grayscale(isPastTrip ? 1 : 0)
//        .onAppear {
//            if !isPastTrip {
//                self.countDownString = countDownString(from: Date())
//             _ = timer
//            }
//        }
//
//    }
