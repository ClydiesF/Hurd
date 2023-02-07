//
//  SwiftUIView.swift
//  Hurd
//
//  Created by clydies freeman on 2/5/23.
//

import SwiftUI

struct SwiftUIView: View {
    var body: some View {
        VStack {
            Text("23")
                .font(.system(size: 25))
                .fontWeight(.bold)
            Text("JAN")
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(.white)       .shadow(color: .gray.opacity(0.3), radius: 5, x: 3, y: 3))
 
        
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
