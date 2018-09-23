//
//  CatalogParser.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

func parseCatalog(completion: (Error?, [CatalogItem]?) -> Void) {
    guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
        print("Coud not find data file.")
        return
    }
    let url = URL(fileURLWithPath: path)
    let jsonData = try? Data(contentsOf: url)
    completion(nil, [])
}
