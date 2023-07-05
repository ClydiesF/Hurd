//
//  SignInWithAppleButtonView.swift
//  Hurd
//
//  Created by clydies freeman on 1/28/23.
//

import SwiftUI
import AuthenticationServices
import CryptoKit
import Firebase

struct SignInWithAppleButtonView: View {
    @State private var currentNonce: String?
    @ObservedObject var vm: AuthenticationViewModel
    let signinType: signInType
    
    var body: some View {
        SignInWithAppleButton( signinType == .signup ? .signUp : .signIn,
                              onRequest: {request in
            let nonce = randomNonceString()
            currentNonce = nonce
            request.requestedScopes = [.fullName, .email]
            request.nonce = sha256(nonce)
        }, onCompletion: {result in
            switch result {
            case .success(let authResult):
                switch authResult.credential {
                case let appleIDCredential as ASAuthorizationAppleIDCredential:
                    guard let nonce = currentNonce else {
                        fatalError("Invalid state: A login calback was recieved, but no login request was sent.")
                    }
                    
                    guard let appleIDToken = appleIDCredential.identityToken else {
                        print("Unable to fetch identityu token")
                        return
                    }
                    
                    guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                        print("Unable to seriailize token string from data: \(appleIDToken.debugDescription)")
                        return
                    }
                    let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
                    
                    vm.signinWithApple(credential: credential, signinType: signinType)
                      
                default: break
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        .signInWithAppleButtonStyle(.black)
        .frame(height: 44)
    }
    
    // MARK: - Functions
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    
    func sha256(_ input: String) -> String {
      let inputData = Data(input.utf8)
      let hashedData = SHA256.hash(data: inputData)
      let hashString = hashedData.compactMap {
        String(format: "%02x", $0)
      }.joined()

      return hashString
    }
}

struct SignInWithAppleButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SignInWithAppleButtonView(vm: AuthenticationViewModel(), signinType: .signup)
    }
}
