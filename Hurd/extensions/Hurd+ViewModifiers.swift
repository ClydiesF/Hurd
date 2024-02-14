//
//  Hurd+ViewModifiers.swift
//  HurdTravel
//
//  Created by clydies freeman on 2/12/24.
//

import Foundation
import SwiftUI

struct Badgestyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .fontWeight(.semibold)
            .font(.system(size: 15))
            .frame(width: 30, height: 30)
            .background(Circle().fill(.black.gradient))
    }
}

extension View {
    func BadgeStyle() -> some View {
        modifier(Badgestyle())
    }
}
