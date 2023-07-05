//
//  SavePopUp.swift
//  Hurd
//
//  Created by clydies freeman on 2/4/23.
//

import SwiftUI

struct SavePopUp: View {
    var body: some View {
        VStack(spacing: 12) {
            Image("SuccessImage")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 226, maxHeight: 226)
            
            Text("Save Success!")
                .foregroundColor(.black)
                .font(.system(size: 24))
                .padding(.top, 12)
            
            Text("You Successfully Saved your info Details, Great now Others can be up to date on who you are!.")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .opacity(0.6)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
        }
        .padding(EdgeInsets(top: 37, leading: 24, bottom: 40, trailing: 24))
        .background(Color.white.cornerRadius(20))
//        .shadowedStyle()
        .padding(.horizontal, 40)
    }
}

struct SavePopUp_Previews: PreviewProvider {
    static var previews: some View {
        SavePopUp()
    }
}
