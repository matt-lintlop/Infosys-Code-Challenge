//
//  ComputerCatalogObject.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Computer Catalog Object
class ComputerCatalogObject: ImageCatalogObject {
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
