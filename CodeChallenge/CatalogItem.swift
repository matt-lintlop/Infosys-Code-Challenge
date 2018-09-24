//
//  CatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Object
class  CatalogItem  {
    var itemIdentifier: String                            // catalog item identifier
    var objectSummary:  CatalogItemSummary                // catalog item summary dictionary
    var indexPath: IndexPath?                             // index path of associated table view cell
    
    enum  CatalogItemType: String {
        case consumerProduct = "consumer product"
        case hardware
        case animal
    }

    private enum DictionaryKeys: String {
        case objectSummary = "object_summary"
    }
    
    init?(itemIdentifier: String, objectDict: Dictionary<String, AnyObject>) {
        self.itemIdentifier = itemIdentifier
        guard let objectSummaryDict = objectDict[DictionaryKeys.objectSummary.rawValue] as? Dictionary<String, String> else {
            return nil
        }
        guard let summary =   CatalogItemSummary(withDictionary: objectSummaryDict) else {
            return nil
        }
        self.objectSummary = summary
   }
}
