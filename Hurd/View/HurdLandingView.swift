//
//  HurdLandingView.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI
import FirebaseAuth

struct HurdLandingView: View {
    
    @State var isUnlocked: Bool = false
    
    // Related to Buttons
    @State private var isLocked = true
    @State private var isLoading = false
    
    @EnvironmentObject var authVM: AuthenticationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                
                Image("landingPageImage")
                    .resizable()
                    .ignoresSafeArea()
                
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
                    
                    UnlockButton(isLocked: $isLocked, isLoading: $isLoading,callbackFunc: navigateToSignUpPage)
                    
                    NavigationLink("Navigator",
                                   destination: HurdSignUpView(),
                                   isActive: $isUnlocked).hidden()
                    
                }
                .padding(.horizontal, 40)
            }
        }
        .onAppear {
            self.isUnlocked = false
            self.isLocked = true
            self.isLoading = false
        }
    }
    
    // MARK: Functions:
    func navigateToSignUpPage() {
        self.isUnlocked = true
    }
}

struct HurdLandingView_Previews: PreviewProvider {
    static var previews: some View {
        HurdLandingView()
    }
}
