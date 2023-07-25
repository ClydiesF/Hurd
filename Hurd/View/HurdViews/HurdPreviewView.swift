//
//  HurdPreviewView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/23/23.
//

import SwiftUI
import Kingfisher

struct HurdPreviewView: View {
    @State var hurdNameString: String = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Hurd Name", text: $hurdNameString,onEditingChanged: { (isBegin) in
                    if isBegin {
                        print("Begins editing")
                    } else {
                        print("Finishes editing")
                    }
                },
                onCommit: {
                    // Fire Firebase function to update hurdname
                    print("commit")
                })
                .submitLabel(.done)
                    .font(.system(size: 13))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                Spacer()
                
                Label("0 / 5", systemImage: "person.fill")
                    .font(.system(size: 13))
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.2)))
                
                
                Menu {
                    Text("Invite Options")
                    Button("via Email", action: {})
                    Button("via Share Link", action: {})
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.white)
                        .font(.system(size: 13))
                        .padding(10)
                        .background(Circle().fill(.black.opacity(0.7)))
                }
                .disabled(false)
            }
            
            HStack {
                Circle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 40, height: 40)
                
                HStack(spacing: -10) {
                    ForEach(0..<4, id: \.self) { i in
                        Circle()
                            .fill(i == 3 ? .black : Color.gray.opacity(0.2))
                            .frame(width: 30, height: 30)

                    }
                  
                }
        
                Spacer()
                
                Button("Manage") {}
                    .buttonStyle(.borderedProminent)
                    .tint(.black)
                
            }
            
        }
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
    }
}

struct HurdPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        HurdPreviewView()
            .padding()
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
