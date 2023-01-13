//
//  HurdMemberPreviewView.swift
//  Hurd
//
//  Created by clydies freeman on 1/13/23.
//

import SwiftUI

struct HurdMemberPreviewView: View {
    var body: some View {
        VStack {
            Image("mockAvatarImage")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
            
            Group {
                Text("Boomy")
                Text("Freeman")
                
                Text("(Leader)")
                    .font(.caption)
            }
            .fontWeight(.semibold)
        }
        .frame(height: 130)
        .padding()
        .background(.orange)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.gray.opacity(0.3),radius: 3, x:5, y:5)
    }
}

struct HurdMemberPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        HurdMemberPreviewView()
    }
}
