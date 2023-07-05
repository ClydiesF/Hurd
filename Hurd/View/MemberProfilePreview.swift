//
//  MemberProfilePreview.swift
//  Hurd
//
//  Created by clydies freeman on 1/13/23.
//

import SwiftUI
import Kingfisher

struct MemberProfilePreview: View {
    let firstName: String
    let lastName: String
    let color: Color
    let image: String?
    var organizer: String? = nil
    
    var body: some View {
        VStack {
            if let imageString = image {
                KFImage(URL(string: imageString))
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
                    .frame(width: 50, height: 50)
                    .scaledToFit()
                    .clipShape(Circle())
            }
   
            Group {
                Text(firstName)
                Text(lastName)
                if let title = organizer {
                    Text(title)
                        .font(.caption)
                        .italic()
                        .padding(.top, 2)
                }
            }
            .font(.system(size: 14))
            .foregroundColor(.white)
            .fontWeight(.semibold)
     
        }
        .frame(minWidth: 70)
        .padding(10)
        .background(color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: Color.gray.opacity(0.3),radius: 3, x:5, y:5)
    }
}

struct MemberProfilePreview_Previews: PreviewProvider {
    static var previews: some View {
        MemberProfilePreview(firstName: "Boom", lastName: "freeman", color: .green, image: "mockAvatarImage", organizer: "Organizer")
    }
}
