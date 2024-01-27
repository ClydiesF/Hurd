//
//  TripComponentView.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/25/23.
//

import SwiftUI
import LinkPresentation

struct TripComponentView: View {
    
    @State var vm: ActivityViewModel
    
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
        TripComponentView(vm: ActivityViewModel(link: "https://www.gamespot.com/articles/moving-out-2-gets-a-nice-discount-ahead-of-august-15-release/1100-6516572/",name: "FakeName", type: .food, description: "A Fod spot that i really like it man and i neeed some one"))
    }
}
