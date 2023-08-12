//
//  HurdFeedPreviewView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/23/23.
//

import SwiftUI

struct HurdFeedPreviewView: View {
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    @State var currentIndex: Int = 0
    
    var body: some View {
        VStack(spacing: 8) {
            HStack(spacing: 8) {
                AsyncImage(url: URL(string: "https://picsum.photos/200/300"), content: { image in
                    image
                        .resizable()
                        .frame(width: 30, height: 30)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(Circle())
                }, placeholder: {
                    ProgressView()
                })
                
                Text("The Hooligans")
                    .font(.system(size: 13))
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.3)))
                
                Spacer()
                Label("5", systemImage: "person.fill")
                    .font(.system(size: 13))
                    .padding(8)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.3)))
                
                Image(systemName: "lock.open")
            }
            .onTapGesture {
                print("DEBUG: tap and go to hurd page")
            }
            
            
            TabView(selection: $currentIndex) {
                TripPreviewView(isPastTrip: .constant(false), trip: Trip.mockTrip2)
                    .tag(0)
                TripPreviewView(isPastTrip: .constant(false), trip: Trip.mockTrip2)
                    .tag(1)
            }
            .frame(height: 100)
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onAppear {
                setupAppearance()
            }
            .onChange(of: currentIndex) { newValue in
                 print("New page: \(newValue)")
            }
            .onTapGesture {
                print("DEBUG: tap and go to trip View page")
            }
            
            HStack {
                ForEach(0..<2) { i in
                    Circle()
                        .fill(i == currentIndex ? .black : .black.opacity(0.3))
                        .frame(width: 6, height: 6)
                    
                }
                .animation(.easeInOut, value: currentIndex)
            }
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(.green.gradient))
      
    }
}

struct HurdFeedPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        HurdFeedPreviewView()
            .padding()
    }
}
