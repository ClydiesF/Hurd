//
//  ProfileViewModel.swift
//  Hurd
//
//  Created by clydies freeman on 1/14/23.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var user: User
    
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    //@Published var profilePicture: String
    @Published var description: String = ""
    @Published var phoneNumber: String = ""
    
    
    init(user: User) {
        self.user = user
    }
    
    func populateCells() {
        
    }
    
    func saveChanges() {
        
    }
    
    // Update name
    
    func updateName() {
        
    }
    
    // update Profile Picture
    
    // Change Phone Number
    
    
    // Update Description
    
    
    // Save Change
    
    
}
