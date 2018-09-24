//
//  Catalog.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

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
