//
//  AnimalCatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

// Animal Catalog Object
class AnimalCatalogItem:VisualCatalogItem {
    let age:String
    let favoriteToy:String              
    
    private enum DictionaryKeys:String {
        case age = "age"
        case favoriteToy = "favorite_toy"
    }
    
    override init?(itemIdentifier:String, objectDict:Dictionary<String, AnyObject>) {
        guard let age = objectDict[DictionaryKeys.age.rawValue] as? String,
            let favoriteToy = objectDict[DictionaryKeys.favoriteToy.rawValue] as? String else {
                return nil
        }
        self.age = age.capitalized
        self.favoriteToy = favoriteToy.capitalized
        super.init(itemIdentifier:itemIdentifier, objectDict:objectDict)
    }
 }
