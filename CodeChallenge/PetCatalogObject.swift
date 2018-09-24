//
//  Pet CatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Pet Catalog Object
class PetCatalogItem: ImageCatalogItem {
    let age: String                                     // pet age
    let favoriteToy: String                             // pet favorite toy
    
    private enum DictionaryKeys: String {
        case age = "age"
        case favoriteToy = "favorite_toy"
    }
    
    override init?(itemIdentifier: String, objectDict: Dictionary<String, AnyObject>) {
        guard let age = objectDict[DictionaryKeys.age.rawValue] as? String,
            let favoriteToy = objectDict[DictionaryKeys.favoriteToy.rawValue] as? String else {
                return nil
        }
        self.age = age
        self.favoriteToy = favoriteToy
        super.init(itemIdentifier: itemIdentifier, objectDict: objectDict)
    }
}
