//
//  ImageReference.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Image Reference
struct ImageReference: Decodable {
    let imageUrlPath: String                            // image url path
    let imageWidth: String                              // image width string (example: "50px")
    let imageHeight: String                             // image height string (example: "50px")
    
    private enum CodingKeys: String, CodingKey, Decodable {
        case imageUrlPath = "url"
        case imageWidth = "width"
        case imageHeight = "height"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrlPath = try container.decode(String.self, forKey:.imageUrlPath)
        self.imageWidth = try container.decode(String.self, forKey:.imageWidth)
        self.imageHeight = try container.decode(String.self, forKey:.imageHeight)
    }
}
