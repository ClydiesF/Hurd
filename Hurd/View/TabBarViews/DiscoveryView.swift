//
//  DiscoveryView.swift
//  Hurd
//
//  Created by clydies freeman on 12/30/22.
//

import SwiftUI

struct DiscoveryView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    @State var presentChangePasswordSheet: Bool = false
    @State var presentChangeEmailSheet: Bool = false
    @State var presentDeleteAccountSheet: Bool = false
    @State var signoutSheet: Bool = false
    
    var body: some View {
        VStack(spacing: Spacing.twentyfour) {
          
            
            
            List {
                
                Text("Settings")
                 
                Section {
                    Button("Change Email") {
                        presentChangeEmailSheet = true
                    }.sheet(isPresented: $presentChangeEmailSheet) {
                        VStack(alignment: .leading) {
                            Group {
                                Text("Update Email")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .padding(.bottom, Spacing.twentyfour)
                                
                                // old password
                                Text("Enter your Password")
                                    .fontWeight(.semibold)
                                HurdPasswordTextField(placeholderText: "Old Password", text: $vm.password, color: $vm.emailTFBorderColor)
                                
                                Divider()
                                    .padding()
                                
                                // new password
                                Text("New email")
                                    .fontWeight(.semibold)
                                HurdTextField(placeholderText: "New email", text: $vm.newEmail, color: $vm.emailTFBorderColor)
                                
                                // confirm new password
                                Text("Confirm Email")
                                    .fontWeight(.semibold)
                                HurdTextField(placeholderText: "Confirm Email", text: $vm.newConfirmEmail, color: $vm.emailTFBorderColor)
                                
                                
                                Text(vm.reauthenticatedStatusMsg)
                                    .font(.caption)
                                    .padding(.vertical, Spacing.twentyfour)
                                
                                Button {
                                    vm.performSensitiveAction(for: .changeEmail)
                                } label: {
                                    Text("Update Email")
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Capsule().fill(Color.bottleGreen))
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .padding(.top, Spacing.sixteen)
                        .presentationDetents([.large])
                        .presentationDragIndicator(.visible)
                        .onAppear {
                            vm.reauthenticatedStatusMsg = ""
                            vm.password = ""
                            vm.newEmail = ""
                            vm.newConfirmEmail = ""
                        }
                    }
                    
                    Button("Change Password") {
                        presentChangePasswordSheet = true
                    }.sheet(isPresented: $presentChangePasswordSheet) {
                        VStack(alignment: .leading) {
                            Group {
                                Text("Update Password")
                                    .font(.title3)
                                    .fontWeight(.heavy)
                                    .padding(.bottom, Spacing.twentyfour)
                                
                                // old password
                                Text("Current Password")
                                    .fontWeight(.semibold)
                                HurdPasswordTextField(placeholderText: "Old Password", text: $vm.password, color: $vm.emailTFBorderColor)
                                
                                Divider()
                                    .padding()
                                
                                // new password
                                Text("New Password")
                                    .fontWeight(.semibold)
                                HurdPasswordTextField(placeholderText: "New Password", text: $vm.newPassword, color: $vm.emailTFBorderColor)
                                
                                // confirm new password
                                Text("Confirm new Password")
                                    .fontWeight(.semibold)
                                HurdPasswordTextField(placeholderText: "Confirm Password", text: $vm.newConfirmedPassword, color: $vm.emailTFBorderColor)
                                
                                
                                Text(vm.reauthenticatedStatusMsg)
                                    .font(.caption)
                                    .padding(.vertical, Spacing.twentyfour)
                                
                                Button {
                                    vm.performSensitiveAction(for: .changePassword)
                                } label: {
                                    Text("Update Password")
                                        .foregroundColor(.white)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Capsule().fill(Color.bottleGreen))
                            }
                            
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
                            vm.newConfirmedPassword = ""
                        }
                    }
                    
                    Button("Sign out") {
                        signoutSheet = true
                    }.sheet(isPresented: $signoutSheet) {
                        VStack(alignment: .leading) {
                            Text("Sign Out")
                                .font(.title3)
                                .fontWeight(.heavy)
                                .padding(.bottom, Spacing.sixteen)
                            
                            Text("Are you sure you want to Sign out?")
                                
                            HStack {
                                Button {
                                    signoutSheet = false
                                } label: {
                                    Text("Cancel")
                                        .foregroundColor(.red)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Capsule().stroke(Color.red, lineWidth: 2))
                                
                                Button {
                                    vm.signout()
                                } label: {
                                    Text("Sign Out")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Capsule().fill(Color.bottleGreen))

                            }
                            Spacer()
                        }
                        .padding()
                        .presentationDetents([.height(200)])
                        .presentationDragIndicator(.visible)
                    }
                } header: {
                    Text("Account Management")
                } footer: {
                    Text("common Methods to manage account")
                }


                
                Button("Delete Account") {
                    presentDeleteAccountSheet = true
                  
                }.sheet(isPresented: $presentDeleteAccountSheet) {
                    VStack(alignment: .leading) {
                        Text("Delete Account")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding(.bottom, Spacing.sixteen)
                        
                        Text("Please enter new password")
                        
                        HurdTextField(placeholderText: "Re-enter Password", text: $vm.newPassword, color: $vm.emailTFBorderColor)
                        
                        Text(vm.reauthenticatedStatusMsg)
                            .font(.caption)
                            .foregroundColor(Color.gray.opacity(0.3))
                            .padding(.vertical, Spacing.twentyfour)
                        
                        Button {
                            vm.performSensitiveAction(for: .deleteAccount)
                        } label: {
                            Text("Delete Account")
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Capsule().fill(Color.bottleGreen))

                        Spacer()
                    }
                    .padding()
                    .presentationDetents([.medium, .large])
                    .presentationDragIndicator(.visible)
                    .onAppear {
                        vm.reauthenticatedStatusMsg = ""
                        vm.newPassword = ""
                    }
                }
                
           
            }
            
         
        }
    }
}

struct DiscoveryView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoveryView()
    }
}
