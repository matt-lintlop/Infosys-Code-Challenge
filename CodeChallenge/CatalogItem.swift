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
    var itemIdentifier: String                            // object identifier
    var objectSummary:  CatalogItemSummary                 // object summary dictionary
   
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
