//
//  User.swift
//  Hurd
//
//  Created by clydies freeman on 1/10/23.
//

import Foundation


struct User: Decodable {
    let createdAt: Double
    let isFinishedOnboarding: Bool
    let emailAddress: String
    let id: String
    let phoneNumber: String
    let bio: String
    let firstName: String
    let lastName: String
    var profileImageUrl: String?
}
