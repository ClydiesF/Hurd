//
//  HurdSignInView.swift
//  Hurd
//
//  Created by clydies freeman on 12/29/22.
//

import SwiftUI

struct HurdSignInView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
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
                        Text("Sign In")
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
                HStack {
                    Spacer()
                    Button {
                        print("Do Something")
                    } label: {
                        Text("Forgot Password?")
                            .font(.caption2)
                            .foregroundColor(.bottleGreen)
                    }
                    
                }
                //                HStack {
                //                   DividerView()
                //                        .padding(.horizontal, 10)
                //                    Text("or")
                //                        .font(.caption)
                //                        .fontWeight(.semibold)
                //                    DividerView()
                //                        .padding(.horizontal, 10)
                //
                //                }
                //                .padding(.top, 10)
                //
                //            HStack(spacing: 50) {
                //                SocialSignInButtonView(iconName: "appleLogo", color: .gray)
                //                SocialSignInButtonView(iconName: "googleLogo", color: .green)
                //                SocialSignInButtonView(iconName: "twitterLogo", color: .blue)
                //            }
                
                Spacer()
                PrimaryHurdButton(buttonModel: .init(buttonText: "Log in", buttonType: .primary, icon: nil, appendingIcon: nil))
                    .padding(.top, 200)
                
                HStack {
                    Spacer()
                    Text("Terms Of Service")
                        .font(.caption)
                    Spacer()
                }
                .padding(.bottom, 40)
            }
        }
        .padding(.horizontal, 20)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            self.presentationMode.wrappedValue.dismiss()
            vm.email = ""
            vm.password = ""
        }, label: {
            Image(systemName: "arrow.backward")
                .foregroundColor(.bottleGreen)
                .fontWeight(.heavy)
                .font(.title3)
        })
        )}
                            }

struct HurdSignInView_Previews: PreviewProvider {
    static var previews: some View {
        HurdSignInView()
            .environmentObject(AuthenticationViewModel())
    }
}
