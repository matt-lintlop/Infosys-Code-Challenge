//
//  PizzaMenu.swift
//  Zume-Code-Challenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation


// Catalog
class PizzaMenu {
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
    }
 
    func downloadAndParsePizzaMenuJSON(completion:@escaping (Error?, [[String:AnyObject]]?) -> Void)  {
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
            // TODO: do something with the data
            print("Downloaded the data: \(jsonData.count) bytes")
            print(String(data: jsonData, encoding: .utf8) ?? "No response data as string")

            self.parsePizzaMenuJSONData(jsonData: jsonData, completion: completion)
            }.resume()
    }

    func parsePizzaMenuJSONData(jsonData: Data, completion:@escaping (Error?, [[String:AnyObject]]?) -> Void)  {
        DispatchQueue.global(qos:.background).async {
             do {
                let pizzaMenuDict = try JSONSerialization.jsonObject(with:jsonData, options:.allowFragments) as! [[String:AnyObject]]
                var pizzaSectionDicts:[[String:AnyObject]] = []
                for pizzaSection in pizzaMenuDict {
                    for (sectionName, _) in pizzaSection {
                        print("section name = \(sectionName)")
                        guard let sectionPizzas = pizzaSection[sectionName] as? [AnyObject] else {
                            continue
                        }
                        print("section pizzas = has \(sectionPizzas.count) pizzas")
                    
                        guard let pizza = sectionPizzas[0] as? [String:AnyObject] else {
                            print("no pizzas in the section")
                            continue
                        }
                        print("1st pizza in section named \(sectionName) is:\n\(pizza)\n")
                        print("\n***********************************************************\n")
                        
                        pizzaSectionDicts.append(pizzaSection)
                    }
                }
                completion(nil, pizzaSectionDicts)
            }
            catch {
                completion(ParsePizzaMenuError.errorParsingPizzaMenuJSON, nil)
            }
        }
    }
}
