//
//  CatalogParser.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

class CatalogParser {
    
    func parseCatalog(completion: (Error?, [CatalogItem]?) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("Error: data file missing.")
            return
        }
        let url = URL(fileURLWithPath: path)
        guard let jsonData = try? Data(contentsOf: url) else {
            print("Error: Coud not load data.")
            return
        }
        do {
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Array<[String: AnyObject]> else {
                return
            }
           print("Loaded JSON: \(json)")
           print("JSON item count: \(json.count)")
            
            completion(nil, [])
        }
        catch {
            print("Error loading json: \(error)")
            completion(error, [])
        }
    }
}
