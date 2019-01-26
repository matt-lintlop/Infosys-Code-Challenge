//
//  Catalog.swift
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

    enum ParseFoodMenuError:Error {
        case errorParsingFoodMenuJSON
    }
    
    init() {
        self.pizzas = []
        self.sectionNames = []
        self.pizzaSectionDict = [:]
    }
 
    func downloadAndParsePizzaJSON(completion:@escaping (Error?, [[String:AnyObject]]?) -> Void)  {
        enum FoodMenuError:Error {
            case errorParsingFoodMenuJSON       // thrown if there is an error parsing the food menu json
            case errorDownloadingFoodMenuJSON   // thrown if there is an error downloading the food menu json
        }
        
        guard let url = URL(string: pizzaDataURLPath) else {
            completion(FoodMenuError.errorDownloadingFoodMenuJSON, nil)
            return
        }
        URLSession.shared.dataTask(with:url) { jsonData, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let jsonData = jsonData, error == nil
                else {
                    completion(FoodMenuError.errorDownloadingFoodMenuJSON, nil)
                    return
            }
            // TODO: do something with the data
            print("Downloaded the data: \(jsonData.count) bytes")
            print(String(data: jsonData, encoding: .utf8) ?? "No response data as string")

            self.parseFoodMenuJSONData(jsonData: jsonData, completion: completion)
            }.resume()
    }

    func parseFoodMenuJSONData(jsonData: Data, completion:@escaping (Error?, [[String:AnyObject]]?) -> Void)  {
        DispatchQueue.global(qos:.background).async {
             do {
                let foodMenuDict = try JSONSerialization.jsonObject(with:jsonData, options:.allowFragments) as! [[String:AnyObject]]
                var pizzaSectionDicts:[[String:AnyObject]] = []
                for pizzaSection in foodMenuDict {
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
                completion(ParseFoodMenuError.errorParsingFoodMenuJSON, nil)
            }
        }
    }
}
