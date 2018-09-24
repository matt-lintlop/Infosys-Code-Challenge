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

    init() {
        self.catalogObjects = nil
    }
    
    func parseJSON(completion: @escaping (Error?, [CatalogObject]?) -> Void) {
        DispatchQueue.global(qos: .background).async {
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
                for (objectName, objectDict) in catalogDict {
                    print("\n\nobject name = \(objectName)")
                    guard let objectDict = objectDict as? Dictionary<String, Any> else {
                        print("Error: could get dictionary")
                        return
                    }
                    print("# objectDict keys = \(objectDict.keys.count)")
                    for key in objectDict.keys {
                        print("\(key)")
                    }
                }
                completion(nil, [])
            }
            catch {
                completion(error,nil)
            }
        }
    }
}
