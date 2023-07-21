//
//  NotesView.swift
//  Hurd
//
//  Created by clydies freeman on 1/17/23.
//

import SwiftUI
import Kingfisher
import Firebase
import PopupView

struct NotesView: View {
    let note:Note
    @ObservedObject var vm: GroupPlannerViewModel
    @State var photoUrl: String = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: Spacing.eight) {
            
            HStack {
                Label(formatTimestamp(), systemImage: "calendar.badge.clock")
                    .font(.system(size: 13))
                    .fontWeight(.semibold)
                Spacer()
                if note.noteType == "Important" {
                    Text("Important")
                        .brightness(-0.5)
                        .font(.system(size: 12))
                        .padding(5)
                        .foregroundColor(.yellow)
                        .background( RoundedRectangle(cornerRadius: 5).fill(Color.yellow).opacity(0.3))
                        .background( RoundedRectangle(cornerRadius: 5).stroke(.yellow))
                }
            }
            
            Divider()
            
            Text(note.title)
                .font(.system(size: 13))
                .fontWeight(.semibold)
            Text(note.body)
                .font(.system(size: 13))
                .foregroundColor(.gray)
            
            HStack {
                KFImage.url(URL(string: photoUrl))
                              .loadDiskFileSynchronously()
                              .cacheMemoryOnly()
                              .fade(duration: 0.25)
                              .resizable()
                              .frame(width: 30,height: 30)
                              .clipShape(Circle())
                Spacer()
            }
            
        }// Parent Stack
        .padding(10)
        .background(RoundedRectangle(cornerRadius: 10).stroke(.gray, lineWidth: 1))
        .onAppear {
            let nc = NetworkCalls()
            Task {
               let author = await nc.fetchUser(with: note.authorID)
                guard let photo = author?.profileImageUrl else { return }
                self.photoUrl = photo
            }
 
        }
        
    }
    
    func formatTimestamp() -> String {
        let ts = Date(timeIntervalSince1970: self.note.timestamp)
        var localTimeZoneAbbreviation: String { return TimeZone.current.abbreviation() ?? "" }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: localTimeZoneAbbreviation) //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MMM d" //Specify your format that you want
        let timestamp = dateFormatter.string(from: ts)

        
        return "\(timestamp)"
    }
}

struct NotesView_Previews: PreviewProvider {
    
    static let vm = GroupPlannerViewModel(trip: Trip.mockTrip, hurd: Hurd.mockHurd)
    static var previews: some View {
        NotesView(note: Note.mockNote, vm: vm)
            .padding()
    }
}

//HStack(alignment:.top, spacing: 10) {
//    VStack {
//        KFImage.url(URL(string: photoUrl))
//                .loadDiskFileSynchronously()
//                .cacheMemoryOnly()
//                .fade(duration: 0.25)
//                .resizable()
//                .frame(width: 40,height: 40)
//                .clipShape(Circle())
//
//        if note.authorID == Auth.auth().currentUser?.uid {
//
//            Button {
//                //Delete this note
//                print("Delete this note")
//                vm.deleteNote(with: note.id ?? "")
//            } label: {
//                Image(systemName: "xmark")
//                    .padding(5)
//                    .foregroundColor(.red)
//                    .background(Circle().fill(Color.red.opacity(0.3)))
//                    .frame(width: 40,height: 40)
//            }
//
//        }
//        }
//
//    // Text Title and Body
//    VStack(alignment: .leading, spacing: 10) {
//        HStack {
//            Text(note.title)
//                .font(.system(size: 17))
//                .fontWeight(.semibold)
//                .foregroundColor(.black)
//
//            Spacer()
//            Label(note.noteType, systemImage: NoteType(rawValue: note.noteType)!.iconString)
//                    .font(.system(size: 12))
//                    .padding(8)
//                    .foregroundColor(note.noteType == "Important" ? .black : .white)
//                    .background(Circle().fill(note.noteType == "Important" ? Color.corn : Color.bottleGreen))
//                    .labelStyle(.iconOnly)
//
//            Text(formatTimestamp())
//                .font(.caption2)
//                .foregroundColor(.black)
//        }
//
//
//        Text(note.body)
//            .font(.system(size: 14))
//            .foregroundColor(.gray)
//    }
//    .popup(isPresented: $vm.noteSuccessDeleted, view: {
//        Text("Successfully deleted Note")
//
//    }, customize: {
//        $0
//        .type (.toast)
//        .position(.bottom)
//        .dragToDismiss(true)
//    })
//}
//.padding()
//.background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
//.shadow(color: Color.gray.opacity(0.3),radius:5,x:3,y:5)
//.onAppear {
//    USER_REF.document(note.authorID).getDocument(as: User.self) { result in
//        switch result {
//        case .success(let user):
//            photoUrl = user.profileImageUrl ?? ""
//
//        case .failure(let err):
//            print("DEBUG: This is a failure \(err)")
//        }
//    }
//}
