//
//  RichLinkView.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/4/23.
//

import SwiftUI
import LinkPresentation

struct RichLinkView: UIViewRepresentable {
    
   var metaData: LPLinkMetadata
   func makeUIView(context: Context) -> LPLinkView {
   
        return LPLinkView(metadata: metaData)
    }

    func updateUIView(_ uiView: LPLinkView, context: Context) {
        // No need to update anything
    }
}

