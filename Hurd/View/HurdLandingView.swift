//
//  HurdLandingView.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI

struct HurdLandingView: View {
    var body: some View {
        ZStack {
            
            Image("landingPageImage")
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack(spacing: 25) {
                    Image("hurdLogo")
                    VStack(alignment: .leading) {
                        Text("Hurd")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Find your herd!")
                            .font(.caption)
                    }
                    .foregroundColor(.bottleGreen)
                }
                .padding(.top, 50)
                .padding(.bottom, 50)
                
                Text("Travel is\nmeant to be \nSocial")
                    .foregroundColor(.bottleGreen)
                    .font(.custom("", size: 45))
                    .fontWeight(.black)
                
                Spacer()
                
                UnlockButton()
                
            }
            .padding(.horizontal, 40)
        }
    }
}

struct HurdLandingView_Previews: PreviewProvider {
    static var previews: some View {
        HurdLandingView()
    }
}
