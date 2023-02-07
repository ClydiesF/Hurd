//
//  AuthenticationMethods.swift
//  Hurd
//
//  Created by clydies freeman on 1/1/23.
//

import Foundation
import FirebaseAuth
import Alamofire

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
