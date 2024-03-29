//
//  OnboardingProfileInfoViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/10/23.
//

import Foundation
import PhotosUI
import SwiftUI
import Combine
import Firebase
import UIKit


class OnboardingProfileInfoViewModel: ObservableObject {
    
    @Published var showPhotosPicker: Bool = false
    @Published var image = UIImage()
    
    var characterLimit = 100
    var maxPhoneNumberCharLimit = 14
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = "" {
        didSet {
            if phoneNumber.count > maxPhoneNumberCharLimit && oldValue.count <= maxPhoneNumberCharLimit {
                phoneNumber = oldValue
            }
         
        }
    }
    
    
    @Published var description: String = ""  {
        didSet {
            if description.count > characterLimit && oldValue.count <= characterLimit {
                description = oldValue
            }
        }
    }
    
    var fieldsArePopulated: Bool {
        return !firstName.isEmpty && !lastName.isEmpty
    }
    
    @Published var characterCount: Int = 0
    @Published var selectedGender: String = ""
    
    @Published var selectedItem: PhotosPickerItem?
    @Published var showfailedImageUploadAlert: Bool = false
    
    @Published var selectedPhotoData: Data?
    
    var gender: [String] = ["","Male", "Female", "Non-Binary"]
    
    
    init() {
        $description
            .map { char -> Int in
                return char.count
            }
            .assign(to: &$characterCount)
        
    }
    
    func addOnboardingInfoData(completion: @escaping (String?) -> Void) {
        let displayName = " \(firstName) \(lastName)"
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        
        let filename = NSUUID().uuidString
        let storageref = profileAvatars.child(filename)
        
        if let photoData = selectedPhotoData {
            storageref.putData(photoData) { _, err in
                if let err = err {
                    print("DEBUG: error in meta is BAD!: \(err.localizedDescription)")
                    return
                }
                storageref.downloadURL { url, err in
                    if let err = err {
                        print("DEBUG: download URL encountered Error: \(err.localizedDescription)")
                        return
                    }
                    
                    changeRequest?.commitChanges { error in
                        if let error = error {
                            print("DEBUG: err add on boarding -> \(error.localizedDescription)")
                            return
                        }
                        let addedData: [String: Any] = [
                            "firstName": self.firstName,
                            "lastName": self.lastName,
                            "phoneNumber": self.phoneNumber,
                            "isFinishedOnboarding": true,
                            "bio": self.description,
                            "profileImageUrl": url?.absoluteString ?? ""
                        ]
                        
                        guard let uid = Auth.auth().currentUser?.uid else { return }
                        
                        USER_REF.document(uid).setData(addedData, merge: true)
                        completion(uid)
                    }
                    
                }
                
            }
        } else {
            changeRequest?.commitChanges { error in
                if let error = error {
                    print("DEBUG: err add on boarding -> \(error.localizedDescription)")
                    return
                }
                let addedData: [String: Any] = [
                    "firstName": self.firstName,
                    "lastName": self.lastName,
                    "phoneNumber": self.phoneNumber,
                    "isFinishedOnboarding": true,
                    "bio": self.description,
                    "profileImageUrl": ""
                ]
                
                guard let uid = Auth.auth().currentUser?.uid else { return }
                
                //USER_REF.document(uid).setData(addedData, merge: true)
                USER_REF.document(uid).setData(addedData, merge: true) { err in
                    if let err {
                        print("DEBUG: ERROR: \(err)")
                    completion(nil)
                    }
                    
                 completion(uid)
                    
                    
                }
       
            }
        }
    }
}

