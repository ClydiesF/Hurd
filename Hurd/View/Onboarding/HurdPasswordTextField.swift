//
//  HurdTextField.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI

struct HurdPasswordTextField: View {
    let placeholderText: String
    @Binding var text: String
    @Binding var color: Color
    @State var showPassword: Bool = false
    
    var body: some View {
        HStack {
            if showPassword {
                TextField(placeholderText, text: $text)
                Button {
                    showPassword.toggle()
                } label: {
                    showPassword ? Image(systemName: "eye") : Image(systemName: "eye.slash")
                }
                .tint(Color("textColor"))
            } else {
                SecureField(placeholderText, text: $text)
                Button {
                    showPassword.toggle()
                } label: {
                    showPassword ? Image(systemName: "eye") : Image(systemName: "eye.slash")
                }
                .tint(Color("textColor"))
            }
        }
        .frame(height: 40)
        .padding(.horizontal, 20)
        .background(Capsule().stroke(color, lineWidth: 2))
        .animation(.easeInOut(duration: 0.4), value: color)
  
    }
}

struct HurdPasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        HurdPasswordTextField(placeholderText: "Enter your name", text: .constant(""), color: .constant(.bottleGreen))
            .padding()
    }
}
