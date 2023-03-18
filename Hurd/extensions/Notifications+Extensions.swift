//
//  Notifications+Extensions.swift
//  Hurd
//
//  Created by clydies freeman on 3/17/23.
//

import Foundation
import SwiftUI

extension Notification {
    var keyboardHeight: CGFloat {
        return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
    }
}
