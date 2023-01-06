//
//  AuthenticationMethods.swift
//  Hurd
//
//  Created by clydies freeman on 1/1/23.
//

import Foundation
import FirebaseAuth

class AuthenticationMethods {
    func signin(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            
            print("\(authResult)")
        }
    }
}
