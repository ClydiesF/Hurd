//
//  OnboardingSliderView.swift
//  Hurd
//
//  Created by clydies freeman on 1/9/23.
//

import SwiftUI

struct OnboardingSliderView: View {
    
    @State private var selectedPage = 0
    
    let onboardingModels: [Onboarding] = [
        .init(
            imageName: "sliderImage1",
            titleText: "Connect with the like-minded",
            bodyText: "Discover new horizons with your friends or meet new people on your travels. Whether you're exploring new cultures, trying new foods, or experiencing new adventures, our app helps you connect with others to make unforgettable memories together."
        ),
        .init(
            imageName: "sliderImage2",
            titleText: "Share Itineraries",
            bodyText: "With our app, you'll always be in the know about the latest travel plans and activities. You can easily communicate with your travel companions and show your support for the activities that interest you the most. Our app helps ensure that everyone has a great time on your travels."
        ),
        .init(
            imageName: "sliderImage3",
            titleText: "Show Off",
            bodyText: "Showcase your travel accomplishments and earn badges for the activities you love to do. Our app lets you track your progress and share your achievements with others. Whether you're a seasoned traveler or just starting out, our app helps you stay motivated and inspired to explore the world."
        )
    ]
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedPage) {
                    Image(onboardingModels[selectedPage].imageName)
                        .resizable()
                        .scaledToFill()
                        .tag(0)
                    
                    Image(onboardingModels[selectedPage].imageName)
                        .resizable()
                        .scaledToFill()
                        .tag(1)
                    
                    Image(onboardingModels[selectedPage].imageName)
                        .resizable()
                        .scaledToFill()
                        .tag(2)
                }
                .frame(height: 400)
                .ignoresSafeArea()
                .tabViewStyle(.page)
                
                Group {
                    Text(onboardingModels[selectedPage].titleText)
                        .font(.title2)
                        .fontWeight(.heavy)
                        .foregroundColor(.bottleGreen)
                        .animation(.easeInOut, value: selectedPage)
                    
                    Text(onboardingModels[selectedPage].bodyText)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .animation(.easeInOut, value: selectedPage)
                    
                    Spacer()
                    
                    HStack(spacing: Spacing.eight) {
                        if selectedPage != 0 {
                            PrimaryHurdButton(buttonModel: .init(buttonText: "Previous", buttonType: .secondary, icon: .arrowLeft, appendingIcon: false), action: {
                                self.selectedPage -= 1
                            })
                        }
                 
                        
                        Spacer()
                        
                        if selectedPage == 2 {
                            NavigationLink {
                                OnboardingProfileInfoView()
                            } label: {
                               Text("Got it")
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Capsule().fill(Color.bottleGreen))
                            }
                        } else {
                            PrimaryHurdButton(buttonModel: .init(buttonText:  selectedPage == 2 ? "Got it" : "Next", buttonType: .primary, icon: .arrowRight, appendingIcon: true), action: {
                                
                                if selectedPage < 2 {
                                    self.selectedPage += 1
                                }
                            })

                        }
                    }
                    .animation(.easeInOut, value: selectedPage)
                }
                .padding()
            }
        }
    }
    
    struct Onboarding {
        let imageName: String
        let titleText: String
        let bodyText: String
    }
}

struct OnboardingSliderView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingSliderView()
    }
}
