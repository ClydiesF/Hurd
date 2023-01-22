//
//  EditProfileView.swift
//  Hurd
//
//  Created by clydies freeman on 1/21/23.
//

import SwiftUI
import PhotosUI
import Kingfisher

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
                    .resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                
                PhotosPicker(selection: $vm.selectedItemPhoto, matching: .any(of: [.images, .not(.livePhotos)])) {
                    Label("Change/Add", systemImage: "photo")
                }
                .onChange(of: vm.selectedItemPhoto) { newItem in
                    Task {
                        
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            vm.selectedPhotoData = data
                            // look into change this method. something combine is not working.
                            vm.changeAvatarImage(photoData: data)
                        } else {
                            //error state this
                        }
                    }
                }
                
                Section {
                    TextField("First Name", text: $vm.firstName)
                    TextField("Last Name", text: $vm.lastName)
                    TextField("Phone Number", text: $vm.phoneNumber)
                    
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
        .navigationBarTitle("Edit Profile")
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(vm: ProfileViewModel(user: User.mockUser1))
    }
}
