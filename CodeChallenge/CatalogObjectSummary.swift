//
//  Catalog.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

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
