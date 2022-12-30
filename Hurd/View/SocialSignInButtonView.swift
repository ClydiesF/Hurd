//
//  SocialSignInButtonView.swift
//  Hurd
//
//  Created by clydies freeman on 12/29/22.
//

import SwiftUI

struct SocialSignInButtonView: View {
    let iconName: String
    let color: Color
    
    var body: some View {
        Button {
            print("nothing")
        } label: {
            Image(iconName)
                .resizable()
                .frame(width: 30, height: 30)
        }
        .padding()
        .background(Circle().fill(color))

    }
}

struct SocialSignInButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SocialSignInButtonView(iconName: "appleLogo", color: .gray)
    }
}
