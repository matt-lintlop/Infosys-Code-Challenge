//
//  CatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Item Summary
enum CatalogItemSummaryKeys: String, Decodable {
    case type                            // item type
    case name                            // item name
    case color                           // item color
    case descreption                     // item descreption
}

// Catalog Item Image
struct CatalogItemImageReference: Decodable  {
    let imageUrlPath: String                    // image url path
    let imageWidth: String                      // image width string (example: "50px")
    let imageHeight: String                     // image height string (example: "50px")
    
    private enum CodingKeys: String, CodingKey {
        case imageUrlPath = "url"
        case imageWidth = "width"
        case imageHeight = "height"
    }
}

// Catalog Item Base Class
class CatalogItem: Decodable {
    let itemIdentifier: CatalogItemIdentifier         // item identifier
    let itemSummaryDict: [String:String]              // item summary dictionary
    let itemContent: [String:String]?                 // item content dictionary

    enum CatalogItemIdentifier: String, Decodable {
        case car
        case computer
        case cat
        case dog
    }
    
    private enum CodingKeys: String, CodingKey {
        case itemIdentifier = "url"
        case itemSummaryDict = "object_summary"
    }

    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

// Pet Catalog Item
class PetCatalogItem: CatalogItem {
    var petImage: CatalogItemImageReference?                // pet image
    let petAge: String                                      // pet age
    let favoriteToy: String                                 // favorite toy
        
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    required init(itemIdentifier: CatalogItemIdentifier, itemSummaryDict: [String : String]) {
        fatalError("init(itemIdentifier:itemSummaryDict:) has not been implemented")
    }
}
