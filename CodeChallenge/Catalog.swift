//
//  Catalog.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Catalog
class Catalog {
    var catalogObjects: [CatalogObject]?                // catalog objects

    init(withDictionary catalogDict: [String:AnyObject]) {
        for (objectName, value) in catalogDict {
            print("\n\nobject name = \(objectName)")
            guard let objectDict = value as? Dictionary<String, Any> else {
                print("Error: could get dictionary")
                return
            }
            print("# objectDict keys = \(objectDict.keys.count)")
            for key in objectDict.keys {
                print("\(key)")
            }
        }
    }
}

// Catalog Object Summary
struct CatalogObjectSummary: Decodable {
    let type: String                                    // object type
    let name: String                                    // object name
    let color: String                                   // object color
    let description: String                             // object description

    private enum CodingKeys: String, CodingKey, Decodable {
        case type
        case name
        case color
        case description
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.type = try container.decode(String.self, forKey:.type)
        self.name = try container.decode(String.self, forKey:.name)
        self.color = try container.decode(String.self, forKey:.color)
        self.description = try container.decode(String.self, forKey:.description)
    }
}

// Image Reference
struct ImageReference: Decodable {
    let imageUrlPath: String                            // image url path
    let imageWidth: String                              // image width string (example: "50px")
    let imageHeight: String                             // image height string (example: "50px")
    
    private enum CodingKeys: String, CodingKey, Decodable {
        case imageUrlPath = "url"
        case imageWidth = "width"
        case imageHeight = "height"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageUrlPath = try container.decode(String.self, forKey:.imageUrlPath)
        self.imageWidth = try container.decode(String.self, forKey:.imageWidth)
        self.imageHeight = try container.decode(String.self, forKey:.imageHeight)
    }
 }

// Catalog Object
class CatalogObject: Decodable  {
    var objectIdentifier: String                            // object identifier
    var objectSummary: CatalogObjectSummary                 // object summary dictionary

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
        self.objectSummary = try container.decode(CatalogObjectSummary.self, forKey:.objectSummary)
        self.objectIdentifier = ""
     }
 
    convenience init?(objectIdentifier: String, objectSummary: CatalogObjectSummary, from decoder: Decoder) throws {
        try self.init(from: decoder)
        self.objectIdentifier = objectIdentifier
        self.objectSummary = objectSummary
    }
}

// Pet Catalog Object
class PetCatalogObject: CatalogObject {
    let age: String                                     // pet age
    let imageReference: ImageReference?           // pet image
    let favoriteToy: String                             // pet favorite toy
    
    private enum CodingKeys: String, CodingKey, Decodable {
        case imageReference = "image"
        case age = "age"
        case favoriteToy = "favorite_toy"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.imageReference = try container.decode(ImageReference.self, forKey:.imageReference)
        self.age = try container.decode(String.self, forKey:.age)
        self.favoriteToy = try container.decode(String.self, forKey:.favoriteToy)
        try super.init(from: decoder)
    }
    
    convenience init?(objectIdentifier: String, objectSummary: CatalogObjectSummary, from decoder: Decoder) throws {
        try self.init(from: decoder)
        self.objectIdentifier = objectIdentifier
        self.objectSummary = objectSummary
   }
}

// Car Catalog Object
class CarCatalogObject: CatalogObject {
    let doors: String
    let price: String
    let milage: String
    
    private enum CodingKeys: String, CodingKey, Decodable {
        case doors
        case price
        case milage
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.doors = try container.decode(String.self, forKey:.doors)
        self.price = try container.decode(String.self, forKey:.price)
        self.milage = try container.decode(String.self, forKey:.milage)
        try super.init(from: decoder)
    }
    
    convenience init?(objectIdentifier: String, objectSummary: CatalogObjectSummary, from decoder: Decoder) throws {
        try self.init(from: decoder)
        self.objectIdentifier = objectIdentifier
        self.objectSummary = objectSummary
    }
}

// Computer Catalog Object
class ComputerCatalogObject: CatalogObject {
    let purchaseDate: String
    
    private enum CodingKeys: String, CodingKey, Decodable {
        case purchaseDate = "purchase_date"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.purchaseDate = try container.decode(String.self, forKey:. purchaseDate)
        try super.init(from: decoder)
    }
    
    convenience init?(objectIdentifier: String, objectSummary: CatalogObjectSummary, from decoder: Decoder) throws {
        try self.init(from: decoder)
        self.objectIdentifier = objectIdentifier
        self.objectSummary = objectSummary
    }
}
