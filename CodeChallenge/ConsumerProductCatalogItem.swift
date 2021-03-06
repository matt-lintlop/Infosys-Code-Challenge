//
//  ConsumerProductCatalogObject.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Car Catalog Object
class ConsumerProductCatalogItem:CatalogItem {
    let doors:String
    let price:String
    let milage:String
    
    private enum DictionaryKeys:String {
        case doors
        case price
        case milage
        case objectImage = "image"
  }
    
    override init?(itemIdentifier:String, objectDict:Dictionary<String, AnyObject>) {
        guard let doors = objectDict[DictionaryKeys.doors.rawValue] as? String,
              let price = objectDict[DictionaryKeys.price.rawValue] as? String,
              let milage = objectDict[DictionaryKeys.milage.rawValue] as? String else {
            return nil
        }
        self.doors = doors.capitalized
        self.price = price.capitalized
        self.milage = milage.capitalized
        super.init(itemIdentifier:itemIdentifier, objectDict:objectDict)
    }
}
