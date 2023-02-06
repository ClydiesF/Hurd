//
//  EditProfileView.swift
//  Hurd
//
//  Created by clydies freeman on 1/21/23.
//

import SwiftUI
import PhotosUI
import Kingfisher
import PopupView

struct EditProfileView: View {
    
    @ObservedObject var vm: ProfileViewModel
    
    let genders = ["","He/Him", "She/Her", "Two-Spirit", "Non-Binary"]
    
    let ethnicities = ["","African-American/Black",
                       "Non-Hispanic, White",
                       "Caucasian",
                       "Asian-Pacific Islander",
                       "Mixed-Race"]
    
    var body: some View {
   
            Form {
                KFImage(URL(string: vm.profilePicture))
                    .placeholder {
                        // Placeholder while downloading.
                        Image("mockAvatarImage")
                            .font(.largeTitle)
                            .opacity(0.3)
                    }
                    .retry(maxCount: 3, interval: .seconds(5))
                    .onSuccess { r in
                        // r: RetrieveImageResult
                        print("success: \(r)")
                    }
                    .onFailure { e in
                        // e: KingfisherError
                        print("failure: \(e)")
                    }
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                PhotosPicker(selection: $vm.selectedItemPhoto,
                             matching: .images,
                             photoLibrary: .shared()) {
                    Label("Change/Add", systemImage: "photo")
                }
                .onChange(of: vm.selectedItemPhoto) { newItem in
                    Task {
                        do {
                            let data = try await newItem?.loadTransferable(type: Data.self)
                            vm.selectedPhotoData = data
                        } catch(let err) {
                            print("DEBUG: photo upload- \(err)")
                        }
                    }
                }
                
                if vm.profilePicture != "" {
                    Button {
                        self.vm.profilePicture = ""
                    } label: {
                        Label("Remove", systemImage: "trash")
                    }
                    .tint(.red)
                }
                
                Section {
                    TextField("First Name", text: $vm.firstName)
                    TextField("Last Name", text: $vm.lastName)
                    TextField("Phone Number", text: $vm.phoneNumber)
                        .keyboardType(.numberPad)
                    
                    Picker("Gender (Optional)", selection: $vm.gender) {
                        ForEach(genders, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                
                
                Picker("Ethnicity (Optional)", selection: $vm.ethnicity) {
                    ForEach(ethnicities, id: \.self) {
                        Text($0)
                    }
                }
                
                Section {
                    TextEditor(text: $vm.bio)
                        .frame(height: 100)
                } header: {
                    Text("Write a short Bio")
                }
                
                Button("Save Changes") {
                    vm.saveChanges()
                }
            }
            .popup(isPresented: $vm.showSaveStatus) {
                SavePopUp()
                    } customize: {
                        $0
                            .autohideIn(4)
                            .backgroundColor(.black.opacity(0.4))
                    }
        .navigationBarTitle("Edit Profile")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(vm: ProfileViewModel(user: User.mockUser1))
    }
}
