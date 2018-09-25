//
//  HardwareCatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Computer Catalog Object
class HardwareCatalogItem:VisualCatalogItem {
    let purchaseDate:String
    
    private enum DictionaryKeys:String {
        case purchaseDate = "purchase_date"
    }
   
    override init?(itemIdentifier:String, objectDict:Dictionary<String, AnyObject>) {
        guard let purchaseDate = objectDict[DictionaryKeys.purchaseDate.rawValue] as? String else {
                return nil
        }
        self.purchaseDate = purchaseDate
        super.init(itemIdentifier:itemIdentifier, objectDict:objectDict)
    }
}
