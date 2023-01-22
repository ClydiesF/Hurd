//
//  ProfileViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/14/23.
//

import Foundation
import Firebase
import PhotosUI
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var gender: String = ""
    @Published var ethnicity: String = ""
    @Published var profilePicture: String = ""
    @Published var bio: String = ""
    @Published var phoneNumber: String = ""
    
    @Published var selectedPhotoData: Data?
    @Published var selectedItemPhoto: PhotosPickerItem?
    
    
    init(user: User) {
        self.user = user
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.gender = user.gender ?? ""
        self.ethnicity = user.ethnicity ?? ""
        self.profilePicture = user.profileImageUrl ?? ""
        self.phoneNumber = user.phoneNumber ?? ""
        self.bio = user.bio
        
        $selectedPhotoData
            .receive(on: RunLoop.main)
            .sink {  d in
                if let d {
                    self.changeAvatarImage(photoData: d)
                }
            }
    }
    
    func changeAvatarImage(photoData: Data) {
        
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        let filename = NSUUID().uuidString
        let storageref = profileAvatars.child(filename)
        
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
                
                
                changeRequest?.photoURL = url
                
                changeRequest?.commitChanges { error in
                    if let error = error {
                        print("DEBUG: err add on boarding -> \(error.localizedDescription)")
                        return
                    }
                    let addedData: [String: Any] = [
                        "profileImageUrl": url?.absoluteString ?? ""
                    ]
                    
                    guard let uid = Auth.auth().currentUser?.uid else { return }
                    
                    self.profilePicture = url?.absoluteString ?? ""
                    
                    USER_REF.document(uid).setData(addedData, merge: true)
                    
                }
                
                
            }
        }
    }
        
        
        func saveChanges() {
            guard let userID = Auth.auth().currentUser?.uid else { return }
            
            let saveUser: [String: Any] = ["firstName": self.firstName,
                                           "lastName": self.lastName,
                                           "gender": self.gender,
                                           "ethnicity": self.ethnicity,
                                           "bio": self.bio,
                                           "phoneNumber": self.phoneNumber,
                                         
            ]
            
            
            let _ = USER_REF.document(userID).setData(saveUser, merge: true)
        }
    }
