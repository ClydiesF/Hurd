//
//  NotesView.swift
//  Hurd
//
//  Created by clydies freeman on 1/17/23.
//

import SwiftUI

struct NotesView: View {

    var body: some View {
        HStack(alignment:.top, spacing: 15) {
            VStack(){
                Circle()
                    .frame(width: 40,height: 40)
                }
            
            // Text Title and Body
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("PassPorts 🧨")
                        .font(.system(size: 20))
                        .fontWeight(.semibold)
                    
                    Spacer()
                    
                    Text("1/2/22 9:30am")
                        .font(.caption2)
                        .foregroundColor(.black)
                }
              
                    Label("Important", systemImage: NoteType.important.iconString)
                        .font(.system(size: 12))
                        .padding(5)
                        .padding(.horizontal, 8)
                        .background(Capsule().fill(Color.corn))
            
           
                
                Text("Everyone please make sure that your bringing the passports or well we wont be able to go. ")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)  
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
        .shadow(color: Color.gray.opacity(0.3),radius:5,x:3,y:5)
    }
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
            .padding()
    }
}
