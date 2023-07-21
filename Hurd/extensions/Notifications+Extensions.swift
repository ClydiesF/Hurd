//
//  Notifications+Extensions.swift
//  Hurd
//
//  Created by clydies freeman on 3/17/23.
//

import Foundation
import SwiftUI
import UIKit

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}

extension Image {
    @MainActor
    func getUIImage(newSize: CGSize) -> UIImage? {
          let image = resizable()
              .scaledToFill()
              .frame(width: newSize.width, height: newSize.height)
              .clipped()
          return ImageRenderer(content: image).uiImage
      }
}
