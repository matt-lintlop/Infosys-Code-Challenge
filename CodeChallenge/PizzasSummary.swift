//
//  CatalogItemSummary.swift
//  Zume-Code-Challenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Item Summary
struct  PizzasSummary {
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
    
    init?(withDictionary pizzaSummaryDict:Dictionary<String, String>) {
        guard let type = pizzaSummaryDict[DictionaryKeys.type.rawValue], let name = pizzaSummaryDict[DictionaryKeys.name.rawValue],
            let color = pizzaSummaryDict[DictionaryKeys.color.rawValue], let description = pizzaSummaryDict[DictionaryKeys.description.rawValue]
            else {
                return nil
        }
        self.type = type
        self.name = name.capitalized
        self.color = color.capitalized
        self.description = description
    }
}
