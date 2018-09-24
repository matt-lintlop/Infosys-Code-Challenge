//
//  CarCatalogObject.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

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
