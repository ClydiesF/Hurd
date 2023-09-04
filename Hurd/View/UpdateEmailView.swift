//
//  UpdateEmailView.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/25/23.
//

import SwiftUI

struct UpdateEmailView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Update Email")
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
                    Text("NEW EMAIL")
                        .foregroundColor(.gray.opacity(0.5))
                }
                
                Spacer()
                VStack {
                    Divider()
                }
            }
            
            // new password
            TextField("New Email", text: $vm.newEmail)
                .textFieldStyle(BorderedStyle(focused: false))
            
            // confirm new email
            TextField("Confirm Email", text: $vm.newConfirmEmail)
                .textFieldStyle(BorderedStyle(focused: false))
            
            
            
            if vm.reauthenticatedStatusMsg != "" {
                HStack {
                    Text(vm.reauthenticatedStatusMsg)
                        .font(.caption)
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 25).fill(Color.gray.opacity(0.2)))
            }
            
            Button(action: { vm.performSensitiveAction(for: .changeEmail) }, label: {
                Text("Update Email")
                    .frame(height: 40)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 30).fill(LinearGradient(
                        colors: vm.changeEmailAllValid ? [Color(hex: "099773"), Color(hex: "43b692")] : [Color.gray.opacity(0.4)],
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
    UpdateEmailView()
        .environmentObject(AuthenticationViewModel())
}
