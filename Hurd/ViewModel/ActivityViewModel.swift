//
//  ActivityViewModel.swift
//  HurdTravel
//
//  Created by clydies freeman on 7/25/23.
//

import Foundation
import LinkPresentation

enum ActivityType: String {
    case food = "Food"
    case bar = "Bar"
    case movie = "Movie"
    case transportation = "Transportation"
    case other = "Other"
}


class ActivityViewModel : ObservableObject {
    let metadataProvider = LPMetadataProvider()
    
    @Published var metadata: LPLinkMetadata?
    @Published var image: UIImage?
    
    @Published var name: String?
    @Published var description: String = ""
    @Published var type: ActivityType = .other
    
    init(link: String?, name: String?, type: ActivityType, description: String?) {
        // If a  Link exists, and is valid, get meta data and image from it.
        if let link, let url = URL(string: link) {
            metadataProvider.startFetchingMetadata(for: url) { (metadata, error) in
                guard error == nil else {
                    // assertionFailure("Error")
                    return
                }
                DispatchQueue.main.async {
                    self.metadata = metadata
                }
                guard let imageProvider = metadata?.imageProvider else { return }
                imageProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    guard error == nil else {
                        // handle error
                        return
                    }
                    if let image = image as? UIImage {
                        // do something with image
                        DispatchQueue.main.async {
                            self.image = image
                        }
                    } else {
                        print("no image available")
                    }
                }
            }
        }
        
        if let name {
            self.name = name
        }
        
        if let description {
            self.description = description
        }
        
        self.type = type
        
    }
}
