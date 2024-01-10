//
//  SignUpView.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/18/23.
//

import SwiftUI

struct SignUpView: View {
    @EnvironmentObject var vm: AuthenticationViewModel
    let columns = Array(repeating: GridItem(.flexible()), count: 2)
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(spacing: Spacing.eight) {
                        Image("hurdLogo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30)
                        
                        Text("Create Your Account")
                            .fontWeight(.semibold)
                    }
                    .padding(.bottom, Spacing.sixteen)
                    
                    Text("Create your account so you can experience the full breadth of what hurd has to offer.")
                        .multilineTextAlignment(.leading)
                        .font(.system(size: 14))
                        .foregroundColor(.gray.opacity(0.9))
                        .padding(.bottom, Spacing.twentyone)
                    

                    TextField("Enter your email", text: $vm.email)
                        .textFieldStyle(BorderedStyle(focused: false))
                        .autocorrectionDisabled(true)
                        .keyboardType(.emailAddress)
                    
                    LazyVGrid(columns: columns, spacing: 10) {
                        ForEach(vm.emailValidations) { validation in
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
                    .animation(.easeIn(duration: 0.4), value: vm.emailValidations)
                
                    
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
                        ForEach(vm.passwordValidations) { validation in
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
                        ForEach(vm.confirmPasswordValidations) { validation in
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
                    .animation(.easeIn(duration: 0.4), value: vm.confirmPasswordValidations)
                    .padding(.bottom, Spacing.twentyfour)
                    
                    
                    Spacer()
                     
                    Button(action: {
                        print("button submitted")
                        vm.signup()
                    }, label: {
                        Text("Created my account")
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
                    .animation(.easeIn(duration: 0.4), value: vm.allFieldsValid)
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
            .padding(.top, Spacing.eight)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(AuthenticationViewModel())
    }
}

struct BorderedStyle: TextFieldStyle {
  var focused: Bool

  func _body(configuration: TextField<Self._Label>) -> some View {
      configuration
      .padding()
      .background(
          RoundedRectangle(cornerRadius: 25)
              .stroke(
                focused ? Color.red : Color.gray.opacity(0.3), lineWidth: 1
              )
      )
  }}
