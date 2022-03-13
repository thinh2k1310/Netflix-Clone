//
//  YoutubeItem.swift
//  Netflix Clone
//
//  Created by Truong Thinh on 13/03/2022.
//

import Foundation

struct YoutubeSeachResults : Codable {
    let items : [VideoElement]
}
struct VideoElement : Codable {
    let id : ElementId
}
struct ElementId : Codable{
    let videoId : String
}

