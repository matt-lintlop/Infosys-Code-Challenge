//
//  CatalogParser.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

class CatalogParser {
    
    func parseCatalog(completion: (Error?, [CatalogObject]?) -> Void) {
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
            let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Dictionary<String, AnyObject>
            print("Loaded JSON: \(json)")
  //          print("JSON object count: \(json.count)")
            
            completion(nil, [])
        }
        catch {
            print("Error loading json: \(error)")
            completion(error, [])
        }
    }
}
    /*
    func parseCatalog(completion: (Error?, [CatalogObject]?) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            print("Error: data file missing.")
            return
        }
        let url = URL(fileURLWithPath: path)
        guard let jsonData = try? Data(contentsOf: url) else {
            print("Error: Coud not load data.")
            return
        }
 
        let jsonDecoder = JSONDecoder()
        do {
            let results = try jsonDecoder.decode(Drinks.self, from:drinks.data(using: .utf8)!)
            for result in results.drinks {
                print(result.description)
                if let beer = result as? Beer {
                    print(beer.alcohol_content)
                }
            }
        } catch {
            print("Error loading json: \(error)")
            completion(error, [])
        }

        
        do {
            guard let json = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? Array<[String: AnyObject]> else {
                return
            }
            print("Loaded JSON: \(json)")
            print("JSON object count: \(json.count)")
            
            completion(nil,[])
        }
        catch {
            print("Error loading json: \(error)")
            completion(error, nil)
        }
    }}
 */
