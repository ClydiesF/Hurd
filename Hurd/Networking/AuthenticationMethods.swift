//
//  AuthenticationMethods.swift
//  Hurd
//
//  Created by clydies freeman on 1/1/23.
//

import Foundation
import FirebaseAuth
import Alamofire
import FirebaseCore
import GoogleSignIn
import CryptoKit
import AuthenticationServices

class AuthenticationMethods {
// MARK: Properties
    
    fileprivate var currentNonce: String?

    func signin(with email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                print("\(error.localizedDescription)")
                return
            }
            
            print("\(authResult)")
        }
    }
    
    fileprivate func signIn(with credential: AuthCredential) {
        Auth.auth().signIn(with: credential) { authResult, err in
            if let err {
                print("\(err.localizedDescription)")
                return
            }
            
            print("\(authResult)")
        }
    }
    
    func handleGoogleSignIn() {
        print("DEBUG: BUTTON FOR Google IS TAPPED")
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        
        // Create Google Sign In configuration object.
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [self] result, error in
          guard error == nil else {
            // ...
              return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
            print("DEBUG: SUCCESS!!!!!!")
        
            signIn(with: credential)
        }
    }
}

    

    


class APICalls {
//    let accessKey = "OQ56zpALUrsgNX0WDbMccCIsZ1CUDT9fD1skJIUhrY8"
//    
//    func sampleRequest() -> String {
//        AF.request("https://api.unsplash.com/search/photos/?client_id=\(accessKey)&query=dallas,TX").responseDecodable(of: UnSplashResponseModel.self) { response in
//            
//            var photoURL = ""
//            switch response.result {
//            case .success(let res):
//                print("DEBUG: -> success \(res.results[0].urls.regular)")
//                photoURL = "\(res.results[0].urls.regular)"
//            case .failure(_):
//                print("DEBUG: ->err")
//            }
//            
//            return photoURL
//        }
//    }
//
//    
//    
}
