//
//  LodgingSuggestionsView.swift
//  Hurd
//
//  Created by clydies freeman on 1/1/23.
//

import SwiftUI

struct LodgingSuggestionsView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .frame(width: 150, height: 100)
                        TagView(tagName: "SanFransico, CA")
                        TagView(tagName: "The Holiday Inn, At the Palisade")
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Suggestions")
                            .fontWeight(.bold)
                        
                        ForEach((1...4), id: \.self) { _ in
                            VStack(alignment: .leading, spacing: 1) {
                                TagView(tagName: "Boston, MA")
                                TagView(tagName: "The Holiday Inn")
                            }
                        }
                        
                    }
                }
            }
            
            PrimaryHurdButton(buttonModel: .init(buttonText: "Add Suggestion", buttonType: .primary, icon: nil, appendingIcon: nil))
                .frame(width: 170)
                .offset(x: 100, y: 170)
        }
    }
}

struct LodgingSuggestionsView_Previews: PreviewProvider {
    static var previews: some View {
        LodgingSuggestionsView()
    }
}
