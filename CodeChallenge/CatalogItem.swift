//
//  CatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Items
class CatalogItems: Decodable {
    var items: [String:[String:String]]             // catalog item dictionaries
}

// Catalog Item Summary
enum CatalogItemSummaryKeys: String {
    case type                                       // item type
    case name                                       // item name
    case color                                      // item color
    case descreption                                // item descreption
}

// Catalog Item Image
struct CatalogItemImageReference {
    let imageUrlPath: String                        // image url path
    let imageWidth: String                          // image width string (example: "50px")
    let imageHeight: String                         // image height string (example: "50px")
    
    private enum CodingKeys: String {
        case imageUrlPath = "url"
        case imageWidth = "width"
        case imageHeight = "height"
    }
    
    init?(withDictionary dict: [String:String]) {
        guard let imageUrlPath = dict[CodingKeys.imageUrlPath.rawValue], let imageWidth = dict[CodingKeys.imageWidth.rawValue],
        let imageHeight = dict[CodingKeys.imageHeight.rawValue] else {
            return nil
        }
        self.imageUrlPath = imageUrlPath
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
    }
}

// Catalog Item
class CatalogItem: Decodable {
    let itemIdentifier: CatalogItemIdentifier         // item identifier
    let itemSummaryDict: [String:String]              // item summary dictionary

    enum CatalogItemIdentifier: String, Decodable {
        case car
        case computer
        case cat
        case dog
    }
    
    private enum CodingKeys: String, CodingKey {
        case itemSummaryDict = "object_summary"
    }

    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    init(itemIdentifier: String, itemDictionary: [String:String]) {
        
    }
}

// Pet Catalog Item
class PetCatalogItem: CatalogItem {
    var petImage: CatalogItemImageReference?        // pet image
    let petAge: String                              // pet age
    let favoriteToy: String                         // favorite toy
        
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override init(itemIdentifier: String, itemDictionary: [String:String]) {
        super.init(itemIdentifier: itemIdentifier, itemDictionary: itemDictionary)
    }
    }
