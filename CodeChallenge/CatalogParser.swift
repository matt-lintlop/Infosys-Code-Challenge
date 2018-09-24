//
//  CatalogParser.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

class CatalogParser {
    
    func parseCatalog(completion: (Error?, Catalog?) -> Void) {
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
            guard let catalogDict = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String : AnyObject] else {
                print("Error: could not de-serialize json")
                return
            }
            for (name, objectDict) in catalogDict {
                print("name = \(name)")
//                print("objectDict = \(objectDict)")
            }
            let catalog = Catalog(withDictionary: catalogDict)
            
            print("Success! Created catalog.")
            completion(nil, catalog)
        }
        catch {
            print("Error loading json: \(error)")
            completion(error,nil)
        }
    }
}
