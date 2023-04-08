//
//  AuthenticationViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/3/23.
//

import Foundation
import Firebase
import SwiftUI
import FirebaseFirestoreSwift

enum signInType {
    case signup
    case signin
}

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
    @Published var newEmail: String = ""
    @Published var newConfirmEmail: String = ""
    
    @Published var password: String = ""
    @Published var newPassword: String = ""
    @Published var newConfirmedPassword: String = ""
    
    @Published var emailTFBorderColor: Color = Color.gray
    @Published var passwordTFBorderColor: Color = Color.gray
    
    @Published var errorMsg: String = ""
    @Published var presentAlert: Bool = false
    
    @Published var authState: AuthState = .signedOut
    @Published var currentUser: Firebase.User? = nil
    @Published var user: User?
    
    
    // Reset Password Email Send
    @Published var resetStatustMsg: String = ""
    
    // Perform senstitive Action Password
    @Published var reauthenticatedPassword: String = ""
    @Published var reauthenticatedStatusMsg: String = ""
    
    var handle: AuthStateDidChangeListenerHandle?
    
    
    init() {
       currentUser = Auth.auth().currentUser
        registerStateListener()
       registerCurrentUserListener()
        
        $email
            .map { text -> Color in
                if text.count > 0 {
                    return .bottleGreen
                } else {
                    return .gray
                }
            }
            .assign(to: &$emailTFBorderColor)
        
        $password
            .map { text -> Color in
                if text.count > 0 {
                    return .bottleGreen
                } else {
                    return .gray
                }
            }
            .assign(to: &$passwordTFBorderColor)
    }
    
    deinit {
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    // MARK: Auth Functions
    
    func registerCurrentUserListener() {
        guard let uid = currentUser?.uid else { return }
        USER_REF.document(uid).addSnapshotListener { snapshot, err in
            guard let document = snapshot else {
              print("Error fetching document: \(err!)")
              return
            }
            guard let data = document.data() else {
              print("Document data was empty.")
              return
            }
            do {
                
                let result = Result {
                    try document.data(as: User.self)
                }
                
                switch result {
                case .success(let object):
                    self.user = object
                case .failure(let failure):
                    print("DEBUG: Document data was empty.")
                }
            } catch {
              fatalError("DEBUG: Couldn’t decode")
            }
            print("Current data: \(data)")
            }
    }

    
    func getCurrentUserObject(from userID: String) {
        USER_REF.document(userID).getDocument(as: User.self) { result in
          
            switch result {
            case .success(let user):
                self.user = user
                self.authState = .signedIn
                print("DEBUG: decoding wss successful")
            case .failure(let err):
                print("DEBUG: get user errror err -> \(err.localizedDescription)")
            }
        }
    }
    
    private func registerStateListener() {
        handle = Auth.auth().addStateDidChangeListener { _, user in
            print("DEBUG: Sign in state changed")

            if let user = user {
                self.currentUser = user
                
                // assign the user object making the firebase call. here
                self.getCurrentUserObject(from: user.uid)
                
                Auth.auth().removeStateDidChangeListener(self.handle!)
               
                print("DEBUG: User signed in with user ID \(user.uid)")
            }
        }
    }
    
    func signup() {
        if email.isEmpty || password.isEmpty {
            errorMsg = "Please make sure both the Email and Password Fields are Populated."
            presentAlert = true
            return
        }
        
        if !isValidEmailAddr(strToValidate: email) {
            errorMsg = "Email is not valid, please correct."
            presentAlert = true
            return
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    print("Sign in Failed: \(error.localizedDescription)")
                    self.errorMsg = "Sign in Failed: \(error.localizedDescription)"
                    self.presentAlert = true
                    return
                }
                
                switch authResult {
                case .none:
                    print("Could not sign up user.")
                    self.errorMsg = "Sign up Failed: Could not sign up user."
                    self.presentAlert = true
                case .some(let something):
                    print("DEBUG: Sign up Success, \(something)")
                    
                    guard let uid = authResult?.user.uid else { return }
                    
                    USER_REF.document(uid).setData(["emailAddress" : self.email.lowercased() as Any,
                                                     "createdAt": Date().timeIntervalSince1970,
                                                     "isFinishedOnboarding": false,
                                                    "firstName": "",
                                                    "lastName": "",
                                                    "phoneNumber": "",
                                                    "bio": "",
                                                    "id": uid
                                                     ]) { err in
                        if let err = err {
                            print("DEBUG: Error writingh document: \(err)")
                        }
                        self.getCurrentUserObject(from: uid)
                    }
                }
            }
        }
    }
    
    func signinWithApple(credential: Firebase.AuthCredential, signinType: signInType) {
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if (error != nil) {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(error?.localizedDescription as Any)
                print("DEBUG: there was an erro \(error?.localizedDescription)")
                return
            }
            if signinType == .signup {
                guard let uid = authResult?.user.uid else { return }
                
                USER_REF.document(uid).setData(["emailAddress" : "",
                                                 "createdAt": Date().timeIntervalSince1970,
                                                 "isFinishedOnboarding": false,
                                                "firstName": "",
                                                "lastName": "",
                                                "phoneNumber": "",
                                                "bio": "",
                                                "id": uid
                                               ]) { err in
                    if let err = err {
                        print("DEBUG: Error writingh document: \(err)")
                    }
                }
            }
            print("DEBUG: signed in")
            self.currentUser = authResult?.user
            guard let uid = authResult?.user.uid else { return }
            self.getCurrentUserObject(from: uid)
        }
    }
    
    func signin() {
        if email.isEmpty || password.isEmpty {
            errorMsg = "Please make sure both the Email and Password Fields are Populated."
            presentAlert = true
            return
        }
        
        if !isValidEmailAddr(strToValidate: email) {
            errorMsg = "Email is not valid, please correct."
            presentAlert = true
            return
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                if let error = error {
                    print("DEBUG: Sign in Failed: \(error.localizedDescription)")
                    self?.errorMsg = "Sign in Failed: \(error.localizedDescription)"
                    self?.presentAlert = true
                    return
                }
                
                switch authResult {
                case .none:
                    print("DEBUG: Could not sign in user.")
                    self?.errorMsg = "Sign in Failed: Could not sign in user."
                    self?.presentAlert = true
                case .some(let something):
                    print("DEBUG: Sign in Success, \(something)")
                    self?.currentUser = authResult?.user
                    guard let uid = authResult?.user.uid else { return }
                    self?.getCurrentUserObject(from: uid)
                }
            }
        }
    }
    
    func signout() {
        do {
            try Auth.auth().signOut()
            self.authState = .signedOut
        } catch {
            print("DEBUG: Error with Signing out")
            errorMsg = "Error Signing out"
            presentAlert = true
        }
    }
    
    func sendPasswordResetEmail(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { err in
            if let err = err {
                print("DEBUG: failed to send email \(err.localizedDescription)")
                self.resetStatustMsg = err.localizedDescription
            } else {
                // Success Route
                print("DEBUG: Success Reset Email sent.")
                self.resetStatustMsg = "Reset Email has been Successfully Sent to your email Address"
                
            }
        }
    }
    
    func deleteAccount() {
        currentUser?.delete { err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
                self.reauthenticatedStatusMsg = err.localizedDescription
            } else {
                //Account deleted
                print("DEBUG: Success Account Deletion")
                self.authState = .signedOut
                
            }
        }
    }
    
    func changePassword() {
        
        if newPassword != newConfirmedPassword {
            self.reauthenticatedStatusMsg = "Password and new Password must match"
            return
        }
        
        Auth.auth().currentUser?.updatePassword(to: newPassword) { err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
                self.reauthenticatedStatusMsg = err.localizedDescription
            } else {
                //Account deleted
                print("DEBUG: Password changed success")
                self.reauthenticatedStatusMsg = "Password change successful"
            }
        }
    }
    
    func changeEmail() {
        
        if newEmail != newConfirmEmail {
            self.reauthenticatedStatusMsg = "Email and new email must match"
            return
        }
        
        
        Auth.auth().currentUser?.updateEmail(to: newEmail) { err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
                self.reauthenticatedStatusMsg = err.localizedDescription
            } else {
                //Account deleted
                print("DEBUG: Email changed success")
                self.reauthenticatedStatusMsg = "Email change successful"
            }
        }
    }
    
    func isValidEmailAddr(strToValidate: String) -> Bool {
      let emailValidationRegex = "^[\\p{L}0-9!#$%&'*+\\/=?^_`{|}~-][\\p{L}0-9.!#$%&'*+\\/=?^_`{|}~-]{0,63}@[\\p{L}0-9-]+(?:\\.[\\p{L}0-9-]{2,7})*$"  // 1

      let emailValidationPredicate = NSPredicate(format: "SELF MATCHES %@", emailValidationRegex)  // 2

      return emailValidationPredicate.evaluate(with: strToValidate)  // 3
    }
    
    func performSensitiveAction(for actionType: SensitiveActionType) {
        
        let credential = EmailAuthProvider.credential(withEmail: (currentUser?.email)!, password: password)
        
        currentUser?.reauthenticate(with: credential) { authResult, err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
                self.reauthenticatedStatusMsg = err.localizedDescription
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
