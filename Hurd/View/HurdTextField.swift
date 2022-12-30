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
    
    var body: some View {
        HStack {
            TextField(placeholderText, text: $text)
        }
        .frame(height: 40)
        .padding(.horizontal, 20)
        .background(Capsule().fill(Color.gray.opacity(0.4)))
  
    }
}

struct HurdTextField_Previews: PreviewProvider {
    static var previews: some View {
        HurdTextField(placeholderText: "enter your email", text: .constant(""))
            .padding()
    }
}
