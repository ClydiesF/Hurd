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
    
    var body: some View {
        VStack(spacing: Spacing.sixteen) {
            
            Text("let us know some basic info about yourself!")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundColor(.bottleGreen)
            
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
                
                PhotosPicker(selection: $vm.selectedItem, matching: .any(of: [.images, .not(.livePhotos)])) {
                    Label("Pick your Avatar", systemImage: "photo")
                }
                .tint(.bottleGreen)
                .controlSize(.large)
                .buttonStyle(.borderedProminent)
                .onChange(of: vm.selectedItem) { newItem in
                    Task {
                        
                        if let data = try? await newItem?.loadTransferable(type: Data.self) {
                            vm.selectedPhotoData = data
                        } else {
                            //error state this
                        }
                    }
                }
            }
 
            Group {
                TextField("First Name *", text: $vm.firstName)
                    .textFieldStyle(.roundedBorder)
                
                TextField("Last Name *", text: $vm.lastName)
                    .textFieldStyle(.roundedBorder)

            Picker("Gender", selection: $vm.selectedGender) {
                ForEach(vm.gender, id: \.self) {
                    Text($0)
                }
            }
            
    
            TextField("Phone Number", text: $vm.phoneNumber)
                .keyboardType(.phonePad)
                .textFieldStyle(.roundedBorder)
            
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
    
            
            // This will handle navigation to the main app.
            PrimaryHurdButton(buttonModel: .init(buttonText: "All Set!", buttonType: .primary, icon: .arrowRight, appendingIcon: true), action: {
                vm.addOnboardingInfoData { _ in
                    authVM.authState = .signedIn
                }
            })
        }
        .padding()
    }
}


struct OnboardingProfileInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingProfileInfoView()
    }
}
