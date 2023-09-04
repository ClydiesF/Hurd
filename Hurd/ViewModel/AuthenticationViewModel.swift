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
import AuthenticationServices
import Combine

enum signInType {
    case signup
    case signin
}

enum Field: String {
    case email
    case password
    case confirmPassword
}

enum ValidationState {
    case success
    case failure
}


enum ValidationType {
    case isNotEmpty
    case minCharacters(min: Int)
    case hasSymbols
    case hasUppercasedLetters
    case isValidEmail
    case passwordsMatch(password: String, confirmPassword: String)
    
    func fulfills(string: String) -> Bool {
        switch self {
        case .isNotEmpty:
            return !string.isEmpty
        case .minCharacters(min: let min):
            return string.count > min
        case .hasSymbols:
            return string.hasSpecialCharacters()
        case .hasUppercasedLetters:
            return string.hasUppercasedCharacters()
        case .isValidEmail:
            return string.isValidEmail()
        case .passwordsMatch(password: let password, confirmPassword: let confirmPassword):
            print("DEBUG: Password: \(password)--ConfirmPassword: \(confirmPassword)")
            return (password == confirmPassword) && !password.isEmpty && !confirmPassword.isEmpty
        }
    }
    
    var label: String {
        switch self {
        case .isNotEmpty:
            return "Field not empty"
        case .minCharacters(let min):
            return "Meets char limit \(min)"
        case .hasSymbols:
            return "Has special symbol"
        case .hasUppercasedLetters:
            return "Has uppercased letter"
        case .isValidEmail:
            return "Is valid email"
        case .passwordsMatch:
            return "Passwords match"
        }
    }
}

struct Validation: Identifiable, Equatable {
    static func == (lhs: Validation, rhs: Validation) -> Bool {
        return true
    }
    
    var id: Int
    var field: Field
    var validationType: ValidationType
    var state: ValidationState
    
    init(string: String, id: Int, field: Field, validationType: ValidationType) {
        self.id = id
        self.field = field
        self.validationType = validationType
        self.state = validationType.fulfills(string: string) ? .success : .failure
    }
}
enum SensitiveActionType {
    case deleteAccount
    case changePassword
    case changeEmail
}


class AuthenticationViewModel: ObservableObject {
    @Environment(\.authorizationController) private var authorizationController
    
    enum AuthState {
        case signedOut
        case signedIn
    }
   

    @Published var email: String = ""
    @Published var newEmail: String = ""
    @Published var newConfirmEmail: String = ""
    
    @Published var password: String = ""
    @Published var newPassword: String = ""
    @Published var confirmPassword: String = ""

    
    // MARK: toggle between show and hide states
    @Published var showPassword: Bool = false
    @Published var showNewPassword: Bool = false
    @Published var showConfirmPassword: Bool = false

    
    @Published var passwordValidations: [Validation] = []
    @Published var newPasswordValidations: [Validation] = []
    
    
    @Published var newPasswordConfirmValidations: [Validation] = []
    @Published var confirmPasswordValidations: [Validation] = []
    
    @Published var emailValidations: [Validation] = []
    @Published var isValid: Bool = false
    
     var ecancellableSet: Set<AnyCancellable> = []
    private var pcancellableSet: Set<AnyCancellable> = []
    private var cpcancellableSet: Set<AnyCancellable> = []
    
    
    var allFieldsValid: Bool {
        var isValid = true
        
        let allValidations = passwordValidations + emailValidations + confirmPasswordValidations
        
        for val in allValidations {
            if val.state != .success {
                isValid = false
            }
        }
        
        return isValid
    }
    
    var changePasswordsAllValid: Bool {
        var isValid = true
        
        let allValidations = newPasswordValidations + newPasswordValidations
        
        for val in allValidations {
            if val.state != .success {
                isValid = false
            }
        }
        
        return isValid && !password.isEmpty
    }
    
    var changeEmailAllValid: Bool {
        return !password.isEmpty && !newEmail.isEmpty && !newConfirmEmail.isEmpty
    }
    
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
        
        emailPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.emailValidations, on: self)
            .store(in: &ecancellableSet)
        
        // Validations
        passwordPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.passwordValidations, on: self)
            .store(in: &ecancellableSet)
        
        newPasswordPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.newPasswordValidations, on: self)
            .store(in: &ecancellableSet)

        confirmPasswordPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.confirmPasswordValidations, on: self)
            .store(in: &ecancellableSet)
        
        confirmPasswordPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.newPasswordConfirmValidations, on: self)
            .store(in: &ecancellableSet)
        
    }
    
    deinit {
        guard let handle = handle else { return }
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    // MARK: Validations
    

    
    private var emailPublisher: AnyPublisher<[Validation], Never> {
        $email
            .removeDuplicates()
            .map { email in
                var validations: [Validation] = []
                validations.append(Validation(string: email,
                                              id: 0,
                                              field: .email,
                                              validationType: .isNotEmpty))

                validations.append(Validation(string: email,
                                              id: 1,
                                              field: .email,
                                              validationType: .isValidEmail))
                return validations
            }
            .eraseToAnyPublisher()
    }
    
    private var confirmPasswordPublisher: AnyPublisher<[Validation], Never> {
        $confirmPassword
            .map { confirmPassword in
                print("DEBUG: \(confirmPassword)")

                var validations: [Validation] = []
                validations.append(Validation(string: confirmPassword,
                                              id: 4,
                                              field: .confirmPassword,
                                              validationType: .passwordsMatch(password: self.newPassword.isEmpty ? self.password : self.newPassword, confirmPassword: self.confirmPassword)))
                return validations
            }
            .eraseToAnyPublisher()
    }
    
    private var newPasswordPublisher: AnyPublisher<[Validation], Never> {
        $newPassword
            .map { password in
                print("DEBUG: newPass-- \(password)")

                var validations: [Validation] = []
                validations.append(Validation(string: password,
                                              id: 0,
                                              field: .password,
                                              validationType: .isNotEmpty))

                validations.append(Validation(string: password,
                                              id: 1,
                                              field: .password,
                                              validationType: .minCharacters(min: 8)))

                validations.append(Validation(string: password,
                                              id: 2,
                                              field: .password,
                                              validationType: .hasSymbols))

                validations.append(Validation(string: password,
                                              id: 3,
                                              field: .password,
                                              validationType: .hasUppercasedLetters))
                
                self.newPasswordConfirmValidations = [Validation(string: password,
                                              id: 4,
                                              field: .confirmPassword,
                                              validationType: .passwordsMatch(password: self.newPassword, confirmPassword: self.confirmPassword))]
                
                
                return validations
            }
            .eraseToAnyPublisher()
    }
    
     var passwordPublisher: AnyPublisher<[Validation], Never> {
        $password
            .map { password in
                print("DEBUG: \(password)")

                var validations: [Validation] = []
                validations.append(Validation(string: password,
                                              id: 0,
                                              field: .password,
                                              validationType: .isNotEmpty))

                validations.append(Validation(string: password,
                                              id: 1,
                                              field: .password,
                                              validationType: .minCharacters(min: 8)))

                validations.append(Validation(string: password,
                                              id: 2,
                                              field: .password,
                                              validationType: .hasSymbols))

                validations.append(Validation(string: password,
                                              id: 3,
                                              field: .password,
                                              validationType: .hasUppercasedLetters))
                
                self.confirmPasswordValidations = [Validation(string: password,
                                              id: 4,
                                              field: .confirmPassword,
                                              validationType: .passwordsMatch(password: self.password, confirmPassword: self.confirmPassword))]
                
                
                return validations
            }
            .eraseToAnyPublisher()
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
            
                let result = Result {
                    try document.data(as: User.self)
                }
                
                switch result {
                case .success(let object):
                    self.user = object
                case .failure(let failure):
                    print("DEBUG: Document data was empty.\(failure)")
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
                print("DEBUG: there was an erro \(String(describing: error?.localizedDescription))")
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
        
        if newPassword != confirmPassword {
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
        
        if let providerData = currentUser?.providerData {
            for userInfo in providerData {
                switch userInfo.providerID {
                case "google.com":
                    print("Google Login") //google.com ?? apple.com
                    //isVerifiededUser = true
                case "apple.com":
                    print("Apple.com")
                    let appleIDProvider = ASAuthorizationAppleIDProvider()
                      let request = appleIDProvider.createRequest()
                    request.requestedScopes = [.fullName, .email]
                    Task {
                        let result = try? await authorizationController.performRequest(request)
                        switch result {
                        case .appleID(let aSAuthorizationAppleIDCredential):
                            guard let appleIDToken = aSAuthorizationAppleIDCredential.identityToken else {
                                print("Unable to fetch identity token")
                                return
                            }
                            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                                return
                            }
                     
                            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: randomNonceString())
                            perform(action: actionType, with: credential)
                        default:
                            print("We dont care about anything else")
                        }
                        
                    }
                default:
                    print("provider is \(userInfo.providerID)")
                    let credential = EmailAuthProvider.credential(withEmail: (currentUser?.email)!, password: password)
                    perform(action: actionType, with: credential)
                }
            }
        }
    }
    
    fileprivate func perform(action: SensitiveActionType, with credential: AuthCredential ) {
        currentUser?.reauthenticate(with: credential) { authResult, err in
            if let err = err {
                // An error happened
                print("DEBUG: \(err.localizedDescription)")
                self.reauthenticatedStatusMsg = err.localizedDescription
            } else {
                print("DEBUG: Success User authenticated")
                
                switch action {
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



private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  var randomBytes = [UInt8](repeating: 0, count: length)
  let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
  if errorCode != errSecSuccess {
    fatalError(
      "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
    )
  }

  let charset: [Character] =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")

  let nonce = randomBytes.map { byte in
    // Pick a random character from the set, wrapping around if needed.
    charset[Int(byte) % charset.count]
  }

  return String(nonce)
}

    
