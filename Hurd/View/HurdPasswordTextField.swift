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
    @State var showPassword: Bool = false
    
    var body: some View {
        HStack {
            TextField(placeholderText, text: $text)
            Button {
                showPassword.toggle()
            } label: {
                showPassword ? Image(systemName: "eye") : Image(systemName: "eye.slash")
            }
            .tint(.black)

  
        }
        .frame(height: 40)
        .padding(.horizontal, 20)
        .background(Capsule().stroke(Color.gray, lineWidth: 2))
  
    }
}

struct HurdPasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        HurdPasswordTextField(placeholderText: "Enter your name", text: .constant(""))
            .padding()
    }
}
