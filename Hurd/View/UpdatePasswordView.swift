//
//  UpdatePasswordView.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/25/23.
//

import SwiftUI

struct UpdatePasswordView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        VStack(alignment: .leading) {
                Text("Update Password")
                    .font(.title3)
                    .fontWeight(.heavy)
                    .padding(.bottom, Spacing.twentyfour)
                
                // old password
            
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
            HStack(spacing: Spacing.eight) {
                VStack {
                    Divider()
                }
                Spacer()
                VStack {
                    Text("NEW PASSWORD")
                        .foregroundColor(.gray.opacity(0.5))
                }
           
                Spacer()
                VStack {
                    Divider()
                }
            }
                
                // new password
            if vm.showNewPassword {
                TextField("New Password", text: $vm.newPassword)
                    .textFieldStyle(BorderedStyle(focused: false))
                    .overlay {
                        HStack {
                            Spacer()
                            Image(systemName: "eye")
                                .onTapGesture {
                                    print("Button Tapped")
                                    vm.showNewPassword.toggle()
                                }
                                .padding()
                        }
                    }
            } else {
                SecureField("New Password", text: $vm.newPassword)
                    .textFieldStyle(BorderedStyle(focused: false))
                    .overlay {
                        HStack {
                            Spacer()
                            Image(systemName: "eye.slash")
                                .onTapGesture {
                                    print("Button Tapped")
                                    vm.showNewPassword.toggle()
                                }
                                .padding()
                        }
                    }
            }
            
                
                // confirm new password
                
                if vm.showConfirmPassword {
                    TextField("Confirm Password", text: $vm.confirmPassword)
                        .textFieldStyle(BorderedStyle(focused: false))
                        .overlay {
                            HStack {
                                Spacer()
                                Image(systemName: "eye")
                                    .onTapGesture {
                                        print("Button Tapped")
                                        vm.showConfirmPassword.toggle()
                                    }
                                    .padding()
                            }
                        }
                } else {
                    SecureField("Confirm Password", text: $vm.confirmPassword)
                        .textFieldStyle(BorderedStyle(focused: false))
                        .overlay {
                            HStack {
                                Spacer()
                                Image(systemName: "eye.slash")
                                    .onTapGesture {
                                        print("Button Tapped")
                                        vm.showConfirmPassword.toggle()
                                    }
                                    .padding()
                            }
                        }
                }
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(vm.newPasswordValidations) { validation in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(validation.state == .success ? .green : .gray.opacity(0.4))
                        Text(validation.validationType.label)
                            .font(.system(size: 13))
                        
                        Spacer()
                    }
                }
            }
            .animation(.easeIn(duration: 0.4), value: vm.passwordValidations)
            
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(vm.newPasswordConfirmValidations) { validation in
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25)
                            .foregroundColor(validation.state == .success ? .green : .gray.opacity(0.4))
                        Text(validation.validationType.label)
                            .font(.system(size: 13))
                        
                        Spacer()
                    }
                }
            }
            .animation(.easeIn(duration: 0.4), value: vm.newPasswordConfirmValidations)
            .padding(.bottom, Spacing.twentyfour)
                
            if vm.reauthenticatedStatusMsg != "" {
                HStack {
                    Text(vm.reauthenticatedStatusMsg)
                        .font(.caption)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 25).fill(Color.gray.opacity(0.2)))
            }
    
                Button(action: { vm.performSensitiveAction(for: .changePassword) }, label: {
                    Text("Update Password")
                              .frame(height: 40)
                              .foregroundColor(.white)
                              .frame(maxWidth: .infinity)
                      .padding()
                      .background(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(
                        colors: vm.changePasswordsAllValid ? [Color(hex: "099773"), Color(hex: "43b692")] : [Color.gray.opacity(0.4)],
                            startPoint: .leading,
                            endPoint: .trailing
                        )))
                })
            
            
            Spacer()
        }
        .padding()
        .padding(.top, Spacing.sixteen)
        .presentationDetents([.large])
        .presentationDragIndicator(.visible)
        .onAppear {
            vm.reauthenticatedStatusMsg = ""
            vm.newPassword = ""
            vm.password = ""
            vm.confirmPassword = ""
            
        }
    }
}

#Preview {
    UpdatePasswordView()
        .environmentObject(AuthenticationViewModel())
}
