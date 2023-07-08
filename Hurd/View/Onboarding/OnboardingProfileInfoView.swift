//
//  OnboardingProfileInfoView.swift
//  Hurd
//
//  Created by clydies freeman on 1/9/23.
//

import SwiftUI
import PhotosUI


struct OnboardingProfileInfoView: View {
    
    @StateObject var vm = OnboardingProfileInfoViewModel()
    
    @EnvironmentObject var authVM: AuthenticationViewModel
    
    private let phoneNumberFormatter = PhoneNumberFormatter()
    
    var body: some View {
        VStack(spacing: Spacing.sixteen) {
            
            Text("Let us know some basic info about yourself!")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.bottleGreen)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            if let photoData = vm.selectedPhotoData, let image = UIImage(data: photoData) {
                Image(uiImage: image)
                    .resizable()
                    .frame(height: 100)
                    .clipShape(Circle())
            } else {
                Image(systemName: "person.crop.circle.fill")
                    .font(.system(size: 100))
            }
  
            HStack {
                
                if vm.selectedPhotoData != nil {
                    Button {
                        self.vm.selectedPhotoData = nil
                    } label: {
                        Label("Remove", systemImage: "trash")
                    }
                    .tint(.red)
                    .controlSize(.large)
                    .buttonStyle(.borderedProminent)

                }
                
                Button {
                    vm.showPhotosPicker = true
                } label: {
                    Text("Change / Add")
                }
                .sheet(isPresented: $vm.showPhotosPicker) {
                    ImagePicker(sourceType: .photoLibrary, selectedImage: $vm.image)
                }
                .onChange(of: vm.image) { newValue in
                    if let data = newValue.jpegData(compressionQuality: 0.8) {
                        vm.selectedPhotoData = data
                    }
                }
//                PhotosPicker(selection: $vm.selectedItem, matching: .any(of: [.images, .not(.livePhotos)])) {
//                    Label("Pick your Avatar", systemImage: "photo")
//                }
//                .tint(.bottleGreen)
//                .controlSize(.large)
//                .buttonStyle(.borderedProminent)
//                .onChange(of: vm.selectedItem) { newItem in
//                    Task {
//                        
//                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                            vm.selectedPhotoData = data
//                        } else {
//                            //error state this
//                        }
//                    }
//                }
            }
 
            Group {
                TextField("First Name *", text: $vm.firstName)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Last Name *", text: $vm.lastName)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Text("Select Your Gender:")
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    Spacer()
                    
                    Picker("Gender", selection: $vm.selectedGender) {
                        ForEach(vm.gender, id: \.self) {
                            Text($0)
                        }
                    }
                }
                .background(
                    RoundedRectangle(cornerRadius: Spacing.eight).stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )


            
            TextField("Phone Number", text: $vm.phoneNumber)
                .keyboardType(.phonePad)
                .textFieldStyle(.roundedBorder)
                .onChange(of: vm.phoneNumber) { newValue in
                    let formatted = phoneNumberFormatter.string(for: newValue) ?? ""
                    if formatted != newValue {
                        DispatchQueue.main.async {
                            vm.phoneNumber = formatted
                        }
                    }
                }
            
            VStack(alignment: .leading) {
                Text("Tell us what kind of traveler you are!")
                    .font(.callout)
                
                TextEditor(text: $vm.description)
                    .frame(height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: Spacing.eight))
                    .background(RoundedRectangle(cornerRadius: Spacing.eight).stroke(Color.gray.opacity(0.3)))
                
                HStack {
                    Spacer()
                    Text("\(vm.characterCount) / \(vm.characterLimit)")
                        .foregroundColor(.gray.opacity(0.6))
                }
             
            }
            
            Spacer()
            }
    
            Button {
                // This will handle navigation to the main app.
                if vm.fieldsArePopulated {
                    vm.addOnboardingInfoData { uid in
                        if let uid {
                            authVM.getCurrentUserObject(from: uid)
                        }
                        
                        print("DEBUG: Something wrong happened here and is not good here ")
                    }
                  
                }
            } label: {
                Text("All Set!")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Capsule().foregroundColor(vm.fieldsArePopulated ? .bottleGreen : .gray))
            }
            .disabled(!vm.fieldsArePopulated)
        }
        .padding()
    }
}


struct OnboardingProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingProfileInfoView()
    }
}
