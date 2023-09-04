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
    
    private let appStoreURL = URL(string: "https://apps.apple.com/us/app/hurdtravel/id6446421364")
    
    var body: some View {
        VStack(spacing: Spacing.twentyfour) {
          
            List {
                
                Text("Settings")
                 
                Section {
                    Button("Change Email") {
                        presentChangeEmailSheet = true
                    }.sheet(isPresented: $presentChangeEmailSheet) {
                        UpdateEmailView()
                    }
                    
                    Button("Change Password") {
                        presentChangePasswordSheet = true
                    }.sheet(isPresented: $presentChangePasswordSheet) {
                        UpdatePasswordView()
                    }
                    
                    Button("Sign out") {
                        signoutSheet = true
                    }.sheet(isPresented: $signoutSheet) {
                        SignOutConfirmationView(vm: vm, signoutSheet: $signoutSheet)
                    }
                } header: {
                    Text("Account Management")
                } footer: {
                    Text("common Methods to manage account")
                }
                
                Button("Delete Account") {
                    presentDeleteAccountSheet = true
                  
                }.sheet(isPresented: $presentDeleteAccountSheet) {
                    DeleteAccountView()
                }
                
                Section {
                    ShareLink(item: appStoreURL!) {
                        Label("Share App", systemImage:  "square.and.arrow.up")
                    }
                } header: {
                    Text("OTHER")
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

struct SignOutConfirmationView: View {
    var vm: AuthenticationViewModel
    @Binding var signoutSheet: Bool
    
    var body: some View {
        VStack() {
            Text("Sign Out")
                .font(.title3)
                .fontWeight(.heavy)
                .padding(.bottom, Spacing.eight)
            
            Text("Are you sure you want to Sign out?")
                .foregroundColor(.gray)
                .padding(.bottom, Spacing.eight)
            
            HStack {
                
                Button(action: { signoutSheet = false}, label: {
                    Text("Cancel")
                              .frame(height: 40)
                              .foregroundColor(Color.gray.opacity(0.4))
                              .frame(maxWidth: .infinity)
                      .padding()
                      .background(RoundedRectangle(cornerRadius: 30).stroke(Color.gray.opacity(0.4),lineWidth: 1.0))
                })
                
                Spacer()
                
                Button(action: { vm.signout()}, label: {
                    Text("Sign Out")
                              .frame(height: 40)
                              .foregroundColor(.white)
                              .frame(maxWidth: .infinity)
                      .padding()
                      .background(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(
                        colors: [Color(hex: "099773"), Color(hex: "43b692")],
                            startPoint: .leading,
                            endPoint: .trailing
                        )))
                })
                
            }
        }
        .padding()
        .presentationDetents([.height(200)])
        .presentationDragIndicator(.visible)
    }
}

struct DeleteAccountView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    
    var body: some View {
        VStack {
            Text("Delete Account")
                .font(.title3)
                .fontWeight(.semibold)
                .padding(.bottom, Spacing.sixteen)
            
            Text("Please enter new password")
                .foregroundColor(.gray.opacity(0.6))
            
            
            if vm.showConfirmPassword {
                TextField("Re-enter Password", text: $vm.confirmPassword)
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
                SecureField("Re-enter Password", text: $vm.confirmPassword)
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
            
            Text(vm.reauthenticatedStatusMsg)
                .font(.caption)
                .foregroundColor(Color.gray.opacity(0.8))
                .padding(.vertical, Spacing.twentyfour)
            
            Button(action: {vm.performSensitiveAction(for: .deleteAccount)}, label: {
                Text("Delete Account")
                          .frame(height: 40)
                          .foregroundColor(.white)
                          .frame(maxWidth: .infinity)
                  .padding()
                  .background(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(
                    colors: vm.confirmPassword != "" ? [Color(hex: "099773"), Color(hex: "43b692")] : [Color.gray.opacity(0.4)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )))
            })
            .animation(.easeIn(duration: 0.4), value: vm.allFieldsValid)
            
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
