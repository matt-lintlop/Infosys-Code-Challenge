//
//  ImageReference.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Image Reference
struct ImageReference {
    let imageUrlPath: String                            // image url path
    let imageWidth: String                              // image width string (example: "50px")
    let imageHeight: String                             // image height string (example: "50px")
    
    private enum Keys: String {
        case imageUrlPath = "url"
        case imageWidth = "width"
        case imageHeight = "height"
    }
    
    init?(withDictionary imageReferenceDict: Dictionary<String, String>) {
        guard let urlPath = imageReferenceDict[Keys.imageUrlPath.rawValue],
              let imageWidth = imageReferenceDict[Keys.imageWidth.rawValue],
              let imageHeight = imageReferenceDict[Keys.imageHeight.rawValue]
        else {
            return nil
        }
        self.imageUrlPath = urlPath
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
}
