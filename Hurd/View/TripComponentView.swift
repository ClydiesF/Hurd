//
//  TripComponentView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/25/23.
//

import SwiftUI
import LinkPresentation

struct TripComponentView: View {
    
    @State var vm: LinkViewModel
    
    var body: some View {
        VStack {
            if let metadata = vm.metadata {
                Text(metadata.title ?? "")
            }
            if let uiImage = vm.image {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: 100, height: 100)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 20).fill(.brown))
    }
}

struct TripComponentView_Previews: PreviewProvider {
    static var previews: some View {
        TripComponentView(vm: LinkViewModel(link: "https://www.marriott.com/en-us/hotels/tosox-moxy-tromso/overview/"))
    }
}
