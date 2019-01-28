//
//  PizzaMenuParser.swift
//  Zume-Code-Challenge
//
//  This class downloads and parses the pizza menu json.
//  A PizzaMenu object is created.
// 
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation


// PizzaMenuParser
class PizzaMenuParser {
    var pizzaSections:[PizzaSection]
    var pizzas:[Pizza]?
    var sectionNames:[String]?
    var pizzaSectionDict:[String:[Pizza]]?
    var error:Error?
    let pizzaDataURLPath = "https://api.myjson.com/bins/snyji"

    enum ParsePizzaMenuError:Error {
        case errorParsingPizzaMenuJSON
    }
    
    init() {
        self.pizzas = []
        self.sectionNames = []
        self.pizzaSectionDict = [:]
        self.pizzaSections = []
    }
 
    func downloadAndParsePizzaMenuJSON(completion:@escaping (Error?, [PizzaSection]?) -> Void)  {
        enum PizzaMenuError:Error {
            case errorParsingPizzaMenuJSON       // thrown if there is an error parsing the pizza menu json
            case errorDownloadingPizzaMenuJSON   // thrown if there is an error downloading the pizza menu json
        }
        
        guard let url = URL(string: pizzaDataURLPath) else {
            completion(PizzaMenuError.errorDownloadingPizzaMenuJSON, nil)
            return
        }
        URLSession.shared.dataTask(with:url) { jsonData, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let jsonData = jsonData, error == nil
                else {
                    completion(PizzaMenuError.errorDownloadingPizzaMenuJSON, nil)
                    return
            }
//            print("Downloaded the data: \(jsonData.count) bytes")
//            print(String(data: jsonData, encoding: .utf8) ?? "No response data as string")

            self.parsePizzaMenuJSONData(jsonData: jsonData, completion: completion)
            }.resume()
    }

    func parsePizzaMenuJSONData(jsonData: Data, completion:@escaping (Error?, [PizzaSection]?) -> Void)  {
        DispatchQueue.global(qos:.background).async {
             do {
                let pizzaMenuDict = try JSONSerialization.jsonObject(with:jsonData, options:.allowFragments) as! [[String:[[String:AnyObject]]]]
                
                for sectionDict in pizzaMenuDict {
                    for (sectionName, sectionPizzas) in sectionDict {
                        print("\n***********************************************************")
                        print("section name = \(sectionName), has \(sectionPizzas.count) pizzas")
                        print("***********************************************************\n")
                    }
//                     guard let pizzaSection = PizzaSection(withDictionary: sectionDict) else {
//                        print("Error parsing pizza section dictionary")
//                        continue
//                    }
//                    if let pizzaCount = pizzaSection.sectionPizzas?.count {
//                        print("\n***********************************************************")
//                        print("section name = \(pizzaSection.sectionName), has \(pizzaCount) pizzas")
//                        print("***********************************************************\n")
//                    }
//                    self.pizzaSections.append(pizzaSection)
                }
                completion(nil, self.pizzaSections)
             }
             catch {
                completion(ParsePizzaMenuError.errorParsingPizzaMenuJSON, nil)
            }
        }
    }
}
