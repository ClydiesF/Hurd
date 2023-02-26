//
//  TagView.swift
//  Hurd
//
//  Created by clydies freeman on 12/29/22.
//

import SwiftUI

struct TagView: View {
    
    let tagName: String
    
    var body: some View {
        Text(tagName)
            .font(.caption2)
            .foregroundColor(Color("backgroundColor"))
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Capsule().fill(Color("textColor")))
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(tagName: "9 days ago")
    }
}
