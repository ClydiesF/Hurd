//
//  UnSplashResponseModel.swift
//  Hurd
//
//  Created by clydies freeman on 2/6/23.
//

import Foundation


struct UnSplashResponseModel: Decodable {
    let total: Int
    let total_pages: Int
    let results:[PhotoResults]
}

struct PhotoResults: Decodable {
    let id: String
    let user: UserData
    let urls: PhotoURLS
    
}

struct UserData: Decodable {
    let id: String
    let username: String
    let name: String
    
}

struct PhotoURLS: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    
}

