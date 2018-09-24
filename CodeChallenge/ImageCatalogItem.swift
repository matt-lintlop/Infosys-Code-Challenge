//
//  Image CatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Object
class ImageCatalogItem:  CatalogItem  {
    let imageReference: ImageReference?                 // pet image
    
    private enum DictionaryKeys: String {
        case objectImage = "image"
    }
    
    override init?(itemIdentifier: String, objectDict: Dictionary<String, AnyObject>) {
        guard let imageRefrenceDict = objectDict[DictionaryKeys.objectImage.rawValue] as? Dictionary<String, String> else {
            return nil
        }
        guard let imageReference =  ImageReference(withDictionary: imageRefrenceDict) else {
            return nil
        }
        self.imageReference = imageReference
        super.init(itemIdentifier: itemIdentifier, objectDict: objectDict)
   }
}
