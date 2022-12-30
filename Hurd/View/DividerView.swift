//
//  DividerView.swift
//  Hurd
//
//  Created by clydies freeman on 12/29/22.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10).fill(Color.gray)
        }
        .frame(height: 1)

            
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
            .padding()
    }
}
