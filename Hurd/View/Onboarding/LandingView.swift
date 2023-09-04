//
//  LandingView.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/19/23.
//

import SwiftUI

struct LandingView: View {
    @State private var showSignInOptions = false
    @State var currentIndex: Int = 0
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                Image("hurdLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80)
                
                Text("Hurd")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                          LinearGradient(
                            colors: [Color(hex: "099773"), Color(hex: "43b692")],
                              startPoint: .leading,
                              endPoint: .trailing
                          )
                      )
                
                TabView(selection: $currentIndex) {
                    TabViewInfoCard(imageName: "landingPageImage")
                    TabViewInfoCard(imageName: "mockAvatarImage")
                    TabViewInfoCard(imageName: "mockbackground")
                }
                .frame(height: 500)
                .tabViewStyle(.page(indexDisplayMode: .always))
                .onReceive(timer, perform: { _ in
                            withAnimation {
                                let index = currentIndex < 3 ? currentIndex + 1 : 0
                                currentIndex = index
                            }
                        })
                
                    Button(action: { showSignInOptions = true }, label: {
                        Text("Start")
                                  .frame(height: 40)
                                  .foregroundColor(.white)
                                  .frame(maxWidth: .infinity)
                          .padding()
                          .background(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(
                            colors:[Color(hex: "099773"), Color(hex: "43b692")],
                                startPoint: .leading,
                                endPoint: .trailing
                            )))
                    })
                
            }
            .navigationDestination(isPresented: $showSignInOptions, destination: {
                SigninOptionsView()
            })
            .padding(.horizontal, Spacing.sixteen)
        }
       
    }
}

#Preview {
    LandingView()
}

struct TabViewInfoCard: View {
    var imageName: String
    
    var body: some View {
        VStack {
             Image(imageName)
                    .resizable()
                    .frame(height: 250)
                    .frame(maxWidth: .infinity)
                    .clipShape(RoundedRectangle(cornerRadius: 25))
            
            Text("Democratuze the planning process")
                .font(.title)
            
            Text("This is so cool and its whty i love this all the things i do and i need it to tbe the main thing that i always do and its soo cool. i know it . ")
                .foregroundColor(.gray)
      
            }
        }
}
