//
//  LoginView.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/19/23.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(spacing: Spacing.eight) {
                        Image("hurdLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                        
                        Text("Login")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.bottom, Spacing.sixteen)
                    
                    Text("Login in with your credentials and get back to leading the pack")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 14))
                        .foregroundColor(.gray.opacity(0.9))
                        .padding(.bottom, Spacing.twentyone)
                    
                    TextField("Enter your email", text: $vm.email)
                        .textFieldStyle(BorderedStyle(focused: false))
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                    
                    if vm.showPassword {
                        TextField("Enter your password", text: $vm.password)
                            .textFieldStyle(BorderedStyle(focused: false))
                            .overlay {
                                HStack {
                                    Spacer()
                                    Image(systemName: "eye")
                                        .onTapGesture {
                                            print("Button Tapped")
                                            vm.showPassword.toggle()
                                        }
                                        .padding()
                                }
                            }
                    } else {
                        SecureField("Enter your password", text: $vm.password)
                            .textFieldStyle(BorderedStyle(focused: false))
                            .overlay {
                                HStack {
                                    Spacer()
                                    Image(systemName: "eye.slash") //eye.slash
                                        .onTapGesture {
                                            print("Button Tapped")
                                            vm.showPassword.toggle()
                                        }
                                        .padding()
                                }
                            }
                    }
                    
                    HStack {
                        Spacer()
                        Text("Forgot your Password?")
                            .font(.system(size: 13))
                            .foregroundColor(.bottleGreen)
                            .fontWeight(.semibold)
                            .onTapGesture {
                                print("forgot Password Button Tapped")
                            }
                    }
                    .padding(10)
                    
                    Button(action: {
                        print("button submitted")
                        vm.signin()
                    }, label: {
                        Text("Login")
                            .frame(height: 40)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(
                                colors: vm.allFieldsValid ? [Color(hex: "099773"), Color(hex: "43b692")] : [Color.gray.opacity(0.4)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )))
                    })
                    
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
                .padding(.horizontal, Spacing.sixteen)
            }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AuthenticationViewModel())
    }
}
