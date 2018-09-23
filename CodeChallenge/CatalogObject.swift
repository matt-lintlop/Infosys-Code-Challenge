//
//  CatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog Objects
class CatalogObjects: Decodable {
    var objectsDict: [String:[CatalogObjectSummary]]    // catalog object summaries
}

// Catalog Object Summary
struct CatalogObjectSummary: Decodable {
    let type: String                                    // item type
    let name: String                                    // item name
    let color: String                                   // item color
    let description: String                             // item description

    private enum CodingKeys: String, CodingKey, Decodable {
        case type
        case name
        case color
        case description
    }
    
    init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
}

// Object Image Reference
struct ObjectImageReference: Decodable {
    let imageUrlPath: String                             // image url path
    let imageWidth: String                              // image width string (example: "50px")
    let imageHeight: String                             // image height string (example: "50px")
    
    private enum CodingKeys: String, CodingKey, Decodable {
        case imageUrlPath = "url"
        case imageWidth = "width"
        case imageHeight = "height"
    }
    
    init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
 }

// Catalog Object
class CatalogObject: Decodable  {
    let objectIdentifier: String                            // object identifier
    let objectSummary: CatalogObjectSummary                 // object summary dictionary

    enum CatalogObjectdentifier: String {
        case car
        case computer
        case cat
        case dog
    }
    
    private enum CodingKeys: String, CodingKey, Decodable {
        case objectSummary = "object_summary"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.objectSummary = try container.decode(CatalogObjectSummary.self, forKey: .objectSummary)
        self.objectIdentifier = ""
     }
 
    init(objectIdentifier: String, objectSummary: CatalogObjectSummary) {
        self.objectIdentifier = objectIdentifier
        self.objectSummary = objectSummary
    }
}

// Pet Catalog Object
class PetCatalogObject: CatalogObject {
    let petImage: ObjectImageReference?                           // pet image
    let petAge: String                                      // pet age
    let favoriteToy: String                                 // pet favorite toy
    
    private enum CodingKeys: String, CodingKey, Decodable {
        case petImage = "image"
        case petAge = "age"
        case favoriteToy = "favorite_toy"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.petImage = try container.decode(ObjectImageReference.self, forKey: .petImage)
        self.petAge = try container.decode(String.self, forKey: .petAge)
        self.favoriteToy = try container.decode(String.self, forKey: .favoriteToy)
        try super.init(from: decoder)
    }
    
    convenience init?(objectIdentifier: String, objectSummary: CatalogObjectSummary, from decoder: Decoder) throws {
        try self.init(from: decoder)
    }
}
