//
//  HurdIconButton.swift
//  Hurd
//
//  Created by clydies freeman on 12/28/22.
//

import SwiftUI

struct HurdIconButton: View {
    let icon: HurdIcon
    
    var body: some View {
        Button(action: {}) {
            Image(icon.rawValue)
                .frame(width: 15, height: 15)
        }
        .padding(10)
        .background(Circle().foregroundColor(.black.opacity(0.6)))
    }
}

struct HurdIconButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            HurdIconButton(icon: .bookmark)
            HurdIconButton(icon: .itinarary)
            HurdIconButton(icon: .sharePlane)
            HurdIconButton(icon: .group)
        }

    }
}
