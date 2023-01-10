//
//  HurdLandingView.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI
import FirebaseAuth

struct HurdLandingView: View {
    
    @EnvironmentObject var authVM: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("landingPageImage")
                    .resizable()
                    .ignoresSafeArea()
                    .overlay {
                        Color.black.opacity(0.1)
                            .ignoresSafeArea()
                    }

                
                VStack(alignment: .leading) {
                    HStack(spacing: 25) {
                        Image("hurdLogo")
                        VStack(alignment: .leading) {
                            Text("Hurd")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Find your herd!")
                                .font(.caption)
                        }
                        .foregroundColor(.bottleGreen)
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 50)
                    
                    Text("Travel is\nmeant to be \nSocial")
                        .foregroundColor(.bottleGreen)
                        .font(.custom("", size: 45))
                        .fontWeight(.black)
                    
                    Spacer()
                
          
            
                    NavigationLink(destination: HurdSignUpView()) {
                        Text("Start your journey")
                            .frame(maxWidth: .infinity)
                            .foregroundColor(.white)
                            .fontWeight(.semibold)
                            .padding()
                            .frame(height: 50)
                            .background(Capsule().fill(Color.bottleGreen))
                 
                    }
                    .padding(.bottom, Spacing.fortyeight)
                    
                }
                .padding(.horizontal, 40)
            }
        }
    }
}

struct HurdLandingView_Previews: PreviewProvider {
    static var previews: some View {
        HurdLandingView()
    }
}
