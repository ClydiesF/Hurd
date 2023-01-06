//
//  AppConstants.swift
//  Hurd
//
//  Created by clydies freeman on 1/5/23.
//

import Foundation
import Firebase


let db = Firestore.firestore()

let USER_REF = db.collection("Users")
let HURD_REF = db.collection("Hurds")


enum Spacing {
    static let four: CGFloat = 4
    static let eight: CGFloat = 8
    static let eleven: CGFloat = 11
    static let sixteen: CGFloat = 16
    static let twentyone: CGFloat = 21
    static let twentyfour: CGFloat = 24
    static let thirtytwo: CGFloat = 32
    static let thirtyFour: CGFloat = 34
    static let fortyFive: CGFloat = 45
    static let fortyeight: CGFloat = 48
    static let sixtyfour: CGFloat = 64
}
