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
    let maxPhoneNumberCharLimit = 14
    
    @Published var user: User
    
    @Published var image = UIImage()
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var gender: String = ""
    @Published var ethnicity: String = ""
    @Published var profilePicture: String = ""
    @Published var bio: String = ""
    @Published var phoneNumber: String = "" {
        didSet {
            if phoneNumber.count > maxPhoneNumberCharLimit && oldValue.count <= maxPhoneNumberCharLimit {
                phoneNumber = oldValue
            }
         
        }
    }

    @Published var showPhotosPicker: Bool = false
    @Published var selectedPhotoData: Data?
    @Published var selectedItemPhoto: PhotosPickerItem? = nil
    
    @Published var showSaveStatus: Bool = false
    let phoneNumberFormatter = PhoneNumberFormatter()
    
    // Visibility Shown Variables
    @Published var genderShown: Bool = false
    @Published var ethnicityShown: Bool = false
    @Published var phoneNumberShown: Bool = false
    @Published var emailShown: Bool = false
    
    var listenerRegistration: ListenerRegistration?
    
    init(user: User) {
        self.user = user
        self.firstName = user.firstName
        self.lastName = user.lastName
        self.gender = user.gender ?? ""
        self.ethnicity = user.ethnicity ?? ""
        self.profilePicture = user.profileImageUrl ?? ""
        self.phoneNumber = user.phoneNumber ?? ""
        self.bio = user.bio
        
        //populate visibility preferences as well
        self.genderShown = user.genderShown
        self.ethnicityShown = user.ethnicityShown
        self.phoneNumberShown = user.phoneNumberShown
        self.emailShown = user.emailShown
        subscribe()
        
        $image
            .receive(on: RunLoop.main)
            .sink {  d in
                    if let data = d.jpegData(compressionQuality: 0.8) {
                        self.changeAvatarImage(photoData: data)
                    }
            }
        
        $selectedPhotoData
            .receive(on: RunLoop.main)
            .sink {  d in
                if let d {
                    self.changeAvatarImage(photoData: d)
                }
            }
    }
    
    
    func subscribe() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        if listenerRegistration == nil {
            listenerRegistration = USER_REF.document(uid).addSnapshotListener { snapshot, err in
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
            
            // TODO: Look into separating this logic out for just savings the preference changes.
            
            let saveUser: [String: Any] = ["firstName": self.firstName,
                                           "lastName": self.lastName,
                                           "gender": self.gender,
                                           "ethnicity": self.ethnicity,
                                           "bio": self.bio,
                                           "phoneNumber": self.phoneNumber,
                                           "genderShown": self.genderShown,
                                           "emailShown": self.emailShown,
                                           "phoneNumberShown": self.phoneNumberShown,
                                           "ethnicityShown": self.ethnicityShown,
            ]
            
            
            let _ = USER_REF.document(userID).setData(saveUser, merge: true)
            self.showSaveStatus = true
        }
    // MARK: Methods
    
    func reformatJoinDate() -> String {
        guard let joinDate = user.createdAt else { return "" }
        let ts = Date(timeIntervalSince1970: joinDate)
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM d, yyyy" //Specify your format that you want
        let timestamp = dateFormatter.string(from: ts)
        
        
        return "Joined \(timestamp)"
    }
    }
