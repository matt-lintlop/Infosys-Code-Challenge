//
//  CatalogItemSummary.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Object Summary
struct  CatalogItemSummary {
    let type:String                                    // item type
    let name:String                                    // item name
    let color:String                                   // item color
    let description:String                             // item description

    private enum DictionaryKeys:String {
        case type
        case name
        case color
        case description
    }
    
    init?(withDictionary objectSummaryDict:Dictionary<String, String>) {
        guard let type = objectSummaryDict[DictionaryKeys.type.rawValue], let name = objectSummaryDict[DictionaryKeys.name.rawValue],
            let color = objectSummaryDict[DictionaryKeys.color.rawValue], let description = objectSummaryDict[DictionaryKeys.description.rawValue]
            else {
                return nil
        }
        self.type = type
        self.name = name
        self.color = color
        self.description = description
    }
}
