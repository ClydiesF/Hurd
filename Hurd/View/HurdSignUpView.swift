//
//  HurdSignUpView.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI
import Firebase
import AuthenticationServices
import CryptoKit

struct HurdSignUpView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State var presentTOS: Bool = false
    @State var currentNonce: String?
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topTrailing) {
                //1
                NavigationLink(destination: HurdSignInView()) {
                    Text("Already a member")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(Color.bottleGreen)
                }
                .padding(.trailing, Spacing.twentyfour)
                
                //2
                VStack {
                    Group {
                        Image("hurdLogo")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .padding(.bottom, 10)
                            .padding(.top, 50)
                        
                        Text("Join the herd")
                            .foregroundColor(.bottleGreen)
                            .font(.caption)
                        
                        HStack {
                            Text("Sign Up")
                                .font(.title2)
                                .fontWeight(.heavy)
                            Spacer()
                        }
                        .padding(.vertical
                                 , 10)
                        
                        
                        HStack {
                            Text("Email")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        
                        HurdTextField(placeholderText: "Enter your email", text: $vm.email, color: $vm.emailTFBorderColor)
                        
                        HStack {
                            Text("Password")
                                .font(.caption)
                                .fontWeight(.semibold)
                            Spacer()
                        }
                        .padding(.top, 10)
                        
                        
                        HurdPasswordTextField(placeholderText: "Enter your password", text: $vm.password, color: $vm.passwordTFBorderColor)
                    }
    
                    PrimaryHurdButton(buttonModel: .init(buttonText: "Join now", buttonType: .primary, icon: nil, appendingIcon: nil), action: {
                        vm.signup()
                    })
                        .padding(.top, 200)
                    
                    HStack {
                        Spacer()
                        Button {
                            self.presentTOS = true
                        } label: {
                            Text("Terms Of Service")
                                .font(.caption)
                                .foregroundColor(.bottleGreen)
                        }

                        Spacer()
                    }
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, Spacing.twentyfour)
            }
            .alert(isPresented: $vm.presentAlert) {
                Alert(title: Text("Error"), message: Text(vm.errorMsg))
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "arrow.backward")
                .foregroundColor(.bottleGreen)
                .fontWeight(.heavy)
                .font(.title3)
        })
        )
        .onAppear {
            vm.email = ""
            vm.password = ""
        }
        .sheet(isPresented: $presentTOS) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading) {
                    Text("Terms Of Service")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(.bottom, Spacing.twentyfour)
                    
                    Text(randomText)
                }
            }
            .padding()
            .presentationDetents([.medium, .large])
        }
    }
    //Functions

    
//    func startSignInWithAppleFlow() {
//        let nonce = randomNonceString()
//          currentNonce = nonce
//          let appleIDProvider = ASAuthorizationAppleIDProvider()
//          let request = appleIDProvider.createRequest()
//          request.requestedScopes = [.fullName, .email]
//          request.nonce = sha256(nonce)
//
//          let authorizationController = ASAuthorizationController(authorizationRequests: [request])
//          authorizationController.delegate = self
//          authorizationController.presentationContextProvider = self
//          authorizationController.performRequests()
//
//    }
}

struct HurdSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        HurdSignUpView()
            .environmentObject(AuthenticationViewModel())
    }
}
