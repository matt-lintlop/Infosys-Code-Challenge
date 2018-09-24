//
//  Catalog.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

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
