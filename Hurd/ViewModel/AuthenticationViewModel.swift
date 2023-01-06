//
//  AuthenticationViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/3/23.
//

import Foundation
import Firebase
import SwiftUI

class AuthenticationViewModel: ObservableObject {
    
    enum AuthState {
        case signedOut
        case signedIn
    }
    
    enum SensitiveActionType {
        case deleteAccount
        case changePassword
        case changeEmail
    }
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var newEmail: String = ""
    @Published var newPassword: String = ""
    
    
    @Published var emailTFBorderColor: Color = Color.gray
    @Published var passwordTFBorderColor: Color = Color.gray
    
    
    
    @Published var authState: AuthState = .signedOut
    @Published var currentUser: Firebase.User? = nil
    var handle: AuthStateDidChangeListenerHandle?
    
    
    init() {
        currentUser = Auth.auth().currentUser
        registerStateListener()
        
        $email
            .map { text -> Color in
                if text.count > 0 {
                    return .bottleGreen
                } else {
                    return .gray
                }
            }
            .assign(to: &$emailTFBorderColor)
    }
    
    deinit {
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    // MARK: Auth Functions
    
    private func registerStateListener() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            print("DEBUG: Sign in state changed")
            
            if let user = user {
                self.currentUser = user
                self.authState = .signedIn
                print("DEBUG: User signed in with user ID \(user.uid)")
            }
        }
    }
    
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print("Sign in Failed: \(error.localizedDescription)")
                return
            }
            
            switch authResult {
            case .none:
                print("Could not sign up user.")
            case .some(let something):
                print("DEBUG: Sign up Success, \(something)")
                let uid = authResult?.user.uid
                USER_REF.document(uid!).setData(["emailAddress" : self.email.lowercased() as Any,
                                                 "createdAt": Date().timeIntervalSince1970,
                                                 "isFinishedOnboarding": false,
                                                 "memberID": uid as Any]) { err in
                    if let err = err {
                        print("DEBUG: Error writingh document: \(err)")
                    }
                    self.authState = .signedIn
                }
            }
        }
    }
    
    func signin() {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("DEBUG: Sign in Failed: \(error.localizedDescription)")
                return
            }
            
            switch authResult {
            case .none:
                print("DEBUG: Could not sign in user.")
            case .some(let something):
                print("DEBUG: Sign in Success, \(something)")
                self?.currentUser = authResult?.user
                self?.authState = .signedIn
            }
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.authState = .signedOut
        } catch {
            print("DEBUG: Error with Signing out")
        }
    }
    
    func sendPasswordResetEmail(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            if let err = err {
                print("DEBUG: failed to send email \(err.localizedDescription)")
            }
        }
    }
    
    func deleteAccount() {
        currentUser?.delete { err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
            } else {
                //Account deleted
                print("DEBUG: Success Account Deletion")
                self.authState = .signedOut
                
            }
        }
    }
    
    func changePassword() {
        Auth.auth().currentUser?.updatePassword(to: newPassword) { err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
            } else {
                //Account deleted
                print("DEBUG: Password changed success")
            }
        }
    }
    
    func changeEmail() {
        Auth.auth().currentUser?.updateEmail(to: newEmail) { err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
            } else {
                //Account deleted
                print("DEBUG: Email changed success")
            }
        }
    }
    
    func performSensitiveAction(for actionType: SensitiveActionType) {
        
        let credential = EmailAuthProvider.credential(withEmail: (currentUser?.email)!, password: password)
        
        currentUser?.reauthenticate(with: credential) { authResult, err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
            } else {
                print("DEBUG: Success User authenticated")
                
                switch actionType {
                case .deleteAccount:
                    self.deleteAccount()
                case .changePassword:
                    self.changePassword()
                case .changeEmail:
                    self.changeEmail()
                }
            }
        }
    }
}
