//
//  HurdSignUpView.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI

struct HurdSignUpView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
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
                    
                    HurdTextField(placeholderText: "Enter your email", text: $vm.email, color: vm.emailTFBorderColor)
                    
                    HStack {
                        Text("Password")
                            .font(.caption)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.top, 10)
                    
                    
                    HurdPasswordTextField(placeholderText: "Enter your password", text: $vm.password)
                }
                // ADD Back in LAter
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
                PrimaryHurdButton(buttonModel: .init(buttonText: "Join now", buttonType: .primary, icon: nil, appendingIcon: nil))
                    .onTapGesture {
                        vm.signup()
                    }
                
                HStack {
                    Spacer()
                    Text("Terms Of Service")
                        .font(.caption)
                    Spacer()
                }
                .padding(.bottom, 40)
            }
            .padding(.horizontal, Spacing.twentyfour)
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
    }
}

struct HurdSignUpView_Previews: PreviewProvider {
    static var previews: some View {
        HurdSignUpView()
            .environmentObject(AuthenticationViewModel())
    }
}
