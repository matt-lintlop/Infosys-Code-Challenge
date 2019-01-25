//
//  CatalogItemSummary.swift
//  Zume-Code-Challenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Item Summary
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
    
    init?(withDictionary itemSummaryDict:Dictionary<String, String>) {
        guard let type = itemSummaryDict[DictionaryKeys.type.rawValue], let name = itemSummaryDict[DictionaryKeys.name.rawValue],
            let color = itemSummaryDict[DictionaryKeys.color.rawValue], let description = itemSummaryDict[DictionaryKeys.description.rawValue]
            else {
                return nil
        }
        self.type = type
        self.name = name.capitalized
        self.color = color.capitalized
        self.description = description
    }
}
