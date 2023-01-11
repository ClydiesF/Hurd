//
//  OnboardingSliderView.swift
//  Hurd
//
//  Created by clydies freeman on 1/9/23.
//

import SwiftUI

struct OnboardingSliderView: View {
    
    @State private var selectedPage = 0
    
    
    let onboardingModels: [Onboarding] = [.init(imageName: "sliderImage1",
                                                titleText: "Connect with the like-minded",
                                                bodyText: "Connect with Friedns through travel or connect with other people, you havent yet met and make new memories with eachother"),
                                          .init(imageName: "sliderImage2", titleText: "Share Iteniaries", bodyText: "Always be in the know about what the plans are and show your support on which activities you like best!"),
                                          .init(imageName: "sliderImage3", titleText: "Show Off", bodyText: "Get Badges for what you already love to do!.. let others know how accomplished a travelr you are!")]
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedPage) {
                    Image(onboardingModels[selectedPage].imageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .tag(0)
                    
                    Image(onboardingModels[selectedPage].imageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .tag(1)
                    
                    Image(onboardingModels[selectedPage].imageName)
                        .resizable()
                        .scaledToFill()
                        .ignoresSafeArea()
                        .tag(2)
                }
                .ignoresSafeArea()
                .frame(height: 400)
                .tabViewStyle(.page)
                
                Group {
                    Text(onboardingModels[selectedPage].titleText)
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.bottleGreen)
                        .animation(.easeInOut, value: selectedPage)
                    
                    Text(onboardingModels[selectedPage].bodyText)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
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
