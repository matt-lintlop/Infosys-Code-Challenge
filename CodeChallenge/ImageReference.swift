//
//  ImageReference.swift
//  Zume-Code-Challenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

// Image Reference
struct ImageReference {
    let imageUrlPath:String                            // image url path
    let imageWidth:String                              // image width string (example:"50px")
    let imageHeight:String                             // image height string (example:"50px")
    
    private enum DictionaryKeys:String {
        case imageUrlPath = "url"
        case imageWidth = "width"
        case imageHeight = "height"
    }
    
    init?(withDictionary imageReferenceDict:Dictionary<String, String>) {
        guard let urlPath = imageReferenceDict[DictionaryKeys.imageUrlPath.rawValue],
              let imageWidth = imageReferenceDict[DictionaryKeys.imageWidth.rawValue],
              let imageHeight = imageReferenceDict[DictionaryKeys.imageHeight.rawValue]
        else {
            return nil
        }
        self.imageUrlPath = urlPath
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
}
