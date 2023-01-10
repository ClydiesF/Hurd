//
//  DestinationSuggestionView.swift
//  Hurd
//
//  Created by clydies freeman on 12/31/22.
//

import SwiftUI

struct DestinationSuggestionView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(.gray)
                            .frame(width: 150, height: 100)
                        
                        TagView(tagName: "The Holiday Inn, At the Palisade")
                    }
                    Divider()
                    
                    VStack(alignment: .leading) {
                        Text("Suggestions")
                            .fontWeight(.bold)
                        
                        ForEach((1...4), id: \.self) { _ in
                            TagView(tagName: "Boston, MA")
                        }
                        
                    }
                }
            }
            
            PrimaryHurdButton(buttonModel: .init(buttonText: "Add Suggestion", buttonType: .primary, icon: nil, appendingIcon: nil), action: {})
                .frame(width: 170)
                .offset(x: 100, y: 170)
        }
    }
}

struct DestinationSuggestionView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationSuggestionView()
    }
}
