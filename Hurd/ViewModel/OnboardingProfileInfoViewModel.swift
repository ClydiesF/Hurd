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


class OnboardingProfileInfoViewModel: ObservableObject {
    var characterLimit = 100
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var phoneNumber: String = ""
    @Published var description: String = ""  {
        didSet {
            if description.count > characterLimit && oldValue.count <= characterLimit {
                description = oldValue
            }
        }
    }
    
    @Published var characterCount: Int = 0
    
    @Published var selectedItem: PhotosPickerItem?
    
    @Published var selectedPhotoData: Data?
    
    
    init() {
        $description
            .map { char -> Int in
                return char.count
            }
            .assign(to: &$characterCount)
    }
    
     func addOnboardingInfoData() {
        let displayName = " \(self.firstName) \(self.lastName)"
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = displayName
        changeRequest?.commitChanges { error in
            if let error = error {
                print("DEBUG: err -> \(error.localizedDescription)")
                return
            }
            let addedData: [String: Any] = [
                "firstName": self.firstName,
                "lastName": self.lastName,
                "phoneNumber": self.phoneNumber,
                "isFinishedOnboarding": true,
                "bio": self.description
            ]
            
            guard let uid = Auth.auth().currentUser?.uid else { return }
            
            USER_REF.document(uid).setData(addedData, merge: true)
        }
    }
}

