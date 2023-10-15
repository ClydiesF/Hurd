//
//  SigninOptionsView.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/18/23.
//

import SwiftUI
import AuthenticationServices

struct SigninOptionsView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    @Environment(\.authorizationController) private var authorizationController
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: Spacing.sixteen) {
                
                Image("hurdLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40)
                
                
                Text("Welcome to hurd 👋")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [Color(hex: "099773"), Color(hex: "43b692")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("Where the social trip collaboration empowers all")
                    .multilineTextAlignment(.center)
                    .font(.subheadline)
                    .padding(.bottom, Spacing.sixteen)
                
                Button(action: { AuthenticationMethods().handleGoogleSignIn() }, label: {
                    SignInOptionView(image: "googleLogo", text: "Sign up with Google")
                })
                
                SignInWithAppleButtonView(vm: vm, signinType: .signup)
                
                NavigationLink {
                    SignUpView()
                } label: {
                    SignInOptionView(image: "envelope.fill", text: "Sign up with Email", isSystemImage: true)
                        .tint(.black)
                }
                
                HStack(spacing: Spacing.eight) {
                    VStack {
                        Divider()
                    }
                    
                    Text("OR")
                        .foregroundStyle(.gray.opacity(0.5))
                    VStack {
                        Divider()
                    }
                }
                
                
                NavigationLink {
                    LoginView()
                } label: {
                    Text("Log into my account")
                        .frame(height: 40)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 30).fill(  LinearGradient(
                            colors: [Color(hex: "099773"), Color(hex: "43b692")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )))
                }
                
                
                Spacer()
                
                
                Group {
                    //                        Text("By continuing you agree to Hurd's ") +
                    //                        Text("Privacy Policy ")
                    //                            .fontWeight(.semibold)
                    //                            .font(.system(size: 14))
                    //                            .foregroundColor(.bottleGreen) +
                    //
                    //                        Text("and ") +
                    //                        Text("terms of Service")
                    //                            .fontWeight(.semibold)
                    //                            .font(.system(size: 14))
                    //                            .foregroundColor(.bottleGreen)
                }
                .font(.system(size: 13))
                
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.backward")
                        }
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SigninOptionsView()
        .environmentObject(AuthenticationViewModel())
}

struct SignInOptionView: View {
    
    var image: String
    var text: String
    var isSystemImage: Bool = false
    
    
    var body: some View {
        HStack(spacing: Spacing.sixteen) {
            Spacer()
            
            if isSystemImage {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }else {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
            
            Text(text)
                .tint(.black)
            Spacer()
            
        }
        .frame(height: 40)
        .padding()
        .background(RoundedRectangle(cornerRadius: 30).stroke(Color.gray.opacity(0.3)))
    }
}
