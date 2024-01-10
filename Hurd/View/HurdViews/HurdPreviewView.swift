//
//  HurdPreviewView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/23/23.
//

import SwiftUI
import Kingfisher

struct HurdPreviewView: View {
    private enum Constants {
        static let inviteViaEmail = "Via Email"
        static let inviteViaShareLink = "Via Share Link"
        static let inviteOptions = "Invite Options"
    }
    
    var hurd: Hurd
    @State var showHurdManagementView: Bool = false
    
    var body: some View {
            VStack(spacing: Spacing.eight) {
                // Top Stack
                HStack {
                    Text(hurd.hurdName)
                        .font(.system(size: 13))
                        .fontWeight(.semibold)
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.4)))
                    
                    Spacer()
                    
                    Image(systemName: hurd.isLocked ? "lock.fill" : "lock.open.fill")
                        .font(.system(size: 13))
                        .padding(8)
                        .background(Circle().fill(.white.opacity(0.4)))
                    
                    Label("\(hurd.memberCount) / \(hurd.capacity)", systemImage: "person.fill")
                        .font(.system(size: 13))
                        .padding(8)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.4)))
                    
                    
                    Menu {
                        Text(Constants.inviteOptions)
                        Button(Constants.inviteViaEmail, action: {})
                        Button(Constants.inviteViaShareLink, action: {})
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 13))
                            .padding(8)
                            .background(Circle().fill(.black.opacity(0.7)))
                    }
                    .disabled(false)
                }
                // Member Stack
                HStack {
                    AsyncImage(url: URL(string: "https://picsum.photos/200/300"), content: { image in
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .background(Circle().stroke(.white, lineWidth: 4))
                    }, placeholder: {
                        ProgressView()
                    })
                    
                    HStack(spacing: -10) {
                        ForEach(0..<4, id: \.self) { i in
                            if i == 3 {
                                Circle()
                                    .fill(i == 3 ? .black : Color.gray.opacity(0.2))
                                    .background(Circle().stroke(.white, lineWidth: 4))
                                    .frame(width: 30, height: 30)
                                    .overlay {
                                        Text("+5")
                                            .font(.system(size: 15))
                                            .fontWeight(.semibold)
                                            .foregroundColor(.white)
                                    }
                            } else {
                                AsyncImage(url: URL(string: "https://picsum.photos/200/300"), content: { image in
                                    image
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .aspectRatio(contentMode: .fit)
                                        .clipShape(Circle())
                                        .background(Circle().stroke(.white, lineWidth: 4))
                                    
                                }, placeholder: {
                                    ProgressView()
                                })
                            }
                        }
                        
                    }
                    
                    Spacer()
                    
                
               
                    Button("Manage") { self.showHurdManagementView.toggle()}
                            .buttonStyle(.borderedProminent)
                            .tint(.black)
                    
       
                    
                }
                
                if let description = hurd.description {
                    HStack {
                        Text(description)
                            .font(.system(size: 13))
                            .padding(10)
                        
                        Spacer()
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.white.opacity(0.4)))
                }
            }
            .padding(10)
            .background(RoundedRectangle(cornerRadius: 10).fill(.green.gradient.opacity(1)))
            .navigationDestination(isPresented: $showHurdManagementView) {
                HurdManagementView(hurd: hurd)
            }

    }
}

struct HurdPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HurdPreviewView(hurd: Hurd.mockHurd)
                .padding(15)
            
            HurdPreviewView(hurd: Hurd.mockHurdLocked)
                .padding(15)
            
            HurdPreviewView(hurd: Hurd.mockHurdNoName)
                .padding(15)
        }
    }
}

//HStack {
//    KFImage(URL(string: ""))
//        .resizable()
//        .frame(width: 40, height: 40)
//        .clipShape(Circle())
//        .background(Circle().stroke(Color("textColor").opacity(0.3), lineWidth: 2))
//        .padding(.vertical, 10)
//
//    if let hurdMembers = [] {
//        ForEach(hurdMembers, id: \.id) { member in
//            KFImage(URL(string: member.profileImageUrl ?? ""))
//                .resizable()
//                .frame(width: 30, height: 30)
//                .clipShape(Circle())
//                .background(Circle().stroke(Color("textColor").opacity(0.3), lineWidth: 2))
//                .padding(.vertical, 10)
//        }
//    }
//
//    Spacer()
//}

//    @State var hurdNameString: String = ""
//TextField("Hurd Name", text: $hurdNameString,onEditingChanged: { (isBegin) in
//    if isBegin {
//        print("Begins editing")
//    } else {
//        print("Finishes editing")
//    }
//},
//onCommit: {
//    // Fire Firebase function to update hurdname
//    print("commit")
//})
//.submitLabel(.done)
//    .font(.system(size: 13))
//    .padding(10)
//    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
