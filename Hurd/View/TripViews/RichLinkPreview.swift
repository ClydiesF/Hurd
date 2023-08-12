//
//  RichLinkPreview.swift
//  HurdTravel
//
//  Created by clydies freeman on 8/4/23.
//

import SwiftUI
import LinkPresentation

struct RichLinkPreview: View {
    @StateObject var vm: LinkViewModel
    
    var body: some View {
        HStack(spacing: 10) {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
            }
           
            VStack(alignment: .leading) {
                HStack {
                    Circle()
                        .fill(.gray.opacity(0.8))
                        .frame(width: 30, height: 30)
                    
                    Text("Excursion")
                        .font(.system(size: 13))
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                        .padding(8)
                        .background(
                            RoundedRectangle(cornerRadius: 10).fill(.black))
                    
                    Spacer()
                }
              
                if let title = vm.metadata?.title {
                    Text(title)
                        .font(.system(size: 13))
                }
                if let urlString = vm.metadata?.url?.absoluteString {
                    Text(urlString)
                        .font(.system(size: 13))
                        .foregroundColor(.gray.opacity(0.8))
                }
            }
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 15).fill(.gray.opacity(0.2))
        )
    }
}

struct RichLinkPreview_Previews: PreviewProvider {
    static var previews: some View {
        RichLinkPreview(vm: LinkViewModel(link: "https://www.gamespot.com/articles/moving-out-2-gets-a-nice-discount-ahead-of-august-15-release/1100-6516572/"))
            .padding(10)
    }
}
