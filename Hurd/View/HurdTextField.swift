//
//  HurdTextField.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI

struct HurdTextField: View {
    let placeholderText: String
    @Binding var text: String
    @Binding var color: Color
    
    var body: some View {
        HStack {
            TextField(placeholderText, text: $text)
                .autocorrectionDisabled(true)
                .keyboardType(.emailAddress)
        }
        .frame(height: 40)
        .padding(.horizontal, 20)
        .background(
            Capsule()
                .stroke(color, lineWidth: 2)
        )
        .animation(.easeInOut(duration: 0.4), value: color)
  
    }
}

struct HurdTextField_Previews: PreviewProvider {
    static var previews: some View {
        HurdTextField(placeholderText: "enter your email", text: .constant(""), color: .constant(.bottleGreen))
            .padding()
    }
}
