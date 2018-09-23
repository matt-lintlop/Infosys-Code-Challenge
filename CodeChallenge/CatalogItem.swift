//
//  CatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Item Summary
struct CatalogItemSummary: Decodable {
    let type:String                             // item type
    let name: String                            // item name
    let color: String                           // item color
    let descreption: String                     // item descreption
    
}

// Catalog Item Image
struct CatalogItemImage: Decodable  {
    let urlPath: String                          // item url path
    let widthString: Int                         // item width string
    let heightString: Int                        // item height string
}

// Catalog Item Base Class
class CatalogItem: Decodable {
    let itemIdentifier: String                  // item identifier
    let itemSummary: CatalogItemSummary         // item summary
    
    required init(itemIdentifier: String, itemSummary: CatalogItemSummary) {
        self.itemIdentifier = itemIdentifier
        self.itemSummary = itemSummary
    }
}
