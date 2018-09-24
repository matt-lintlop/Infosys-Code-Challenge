//
//  CatalogObject.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Object
class CatalogObject  {
    var objectIdentifier: String                            // object identifier
    var objectSummary: CatalogObjectSummary                 // object summary dictionary
   
    private enum DictionaryKeys: String {
        case objectSummary = "object_summary"
    }
    
    init?(objectIdentifier: String, objectDict: Dictionary<String, AnyObject>) {
        self.objectIdentifier = objectIdentifier
        guard let objectSummaryDict = objectDict[DictionaryKeys.objectSummary.rawValue] as? Dictionary<String, String> else {
            return nil
        }
        guard let summary =  CatalogObjectSummary(withDictionary: objectSummaryDict) else {
            return nil
        }
        self.objectSummary = summary
   }
}
