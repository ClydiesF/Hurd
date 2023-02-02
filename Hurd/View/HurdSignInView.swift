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
    @Environment(\.dismiss) var dismiss
    
    @State var presentTOS: Bool = false
    @State var presentResetEmailSheet: Bool = false
    @State var showResetStatus: Bool = false
    @State var statusMsg: String = ""
    
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
                    .alert(isPresented: $vm.presentAlert) {
                        Alert(title: Text("Error"), message: Text(vm.errorMsg))
                    }
                    .padding(.top, 10)
                    
                    
                    HurdPasswordTextField(placeholderText: "Enter your password", text: $vm.password, color: $vm.passwordTFBorderColor)
                }
                HStack {
                    Spacer()
                    Button {
                        self.presentResetEmailSheet = true
                    } label: {
                        Text("Forgot Password?")
                            .font(.caption2)
                            .foregroundColor(.bottleGreen)
                    }
                    
                }
                SignInWithAppleButtonView(vm: vm, signinType: .signin)

                Spacer()
                
                PrimaryHurdButton(buttonModel: .init(buttonText: "Log in", buttonType: .primary, icon: nil, appendingIcon: nil), action: {
                    vm.signin()
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
        }
        .sheet(isPresented: $presentResetEmailSheet, content: {
            VStack(alignment: .leading, spacing: Spacing.sixteen) {
                Text("Reset Email")
                    .fontWeight(.semibold)
                
                HurdTextField(placeholderText: "Send Reset Password", text: $vm.newEmail, color: $vm.emailTFBorderColor)
                
                Button {
                    vm.sendPasswordResetEmail(email: vm.newEmail)
                    simulateresetRequest()
                    //self.presentResetEmailSheet = false
                } label: {
                    Text("Reset Email")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Capsule().fill(Color.bottleGreen))
                
                if showResetStatus {
                    ProgressView()
                } else {
                    Text(vm.resetStatustMsg)
                }
                
                
                Spacer()

            }
            .onAppear {
                vm.newEmail = ""
                vm.resetStatustMsg = ""
            }
            .presentationDetents([.medium])
            .padding()
        })
        .onAppear {
            vm.email = ""
            vm.password = ""
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
    // Function
    
    func simulateresetRequest() {
        self.showResetStatus = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
            self.showResetStatus = false
        }
    }
}

struct HurdSignInView_Previews: PreviewProvider {
    static var previews: some View {
        HurdSignInView()
            .environmentObject(AuthenticationViewModel())
    }
}
