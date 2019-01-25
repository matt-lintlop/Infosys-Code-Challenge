//
//  Catalog.swift
//  Zume-Code-Challenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation


// Catalog
class FoodMenu {
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
    }
 
    func downloadAndParsePizzaJSON(completion:@escaping (Error?, [Pizza]?) -> Void)  {
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

            guard let menuDict = try? JSONSerialization.jsonObject(with:jsonData, options:.allowFragments) as! [AnyObject] else {
                completion(FoodMenuError.errorParsingFoodMenuJSON, nil)
                return
            }
            for pizzaSection in menuDict where pizzaSection is [String:AnyObject] {
                //                   print("Found Pizza Section =  \(pizzaSection) that is of type \(type(of:pizzaSection))")
                for sectionName in pizzaSection.keyEnumerator() where sectionName is String {
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
                }
            }

                completion(nil, nil)      // testing
          }.resume()
    }

    func parseJSON(completion:@escaping (Error?, [Pizza]?) -> Void) {
        DispatchQueue.global(qos:.background).async {
             do {
                // TODO: Testing load the pizza data
                guard let path = Bundle.main.path(forResource:"pizza", ofType:"json") else {
                    completion(ParseFoodMenuError.errorParsingFoodMenuJSON, nil)
                    return
                }
                let url = URL(fileURLWithPath:path)
                let jsonData = try Data(contentsOf:url)
                let menuDict = try JSONSerialization.jsonObject(with:jsonData, options:.allowFragments) as! [AnyObject]

//                   print("Found the Menu Dictionary: \(menuDict) that is of type \(type(of:menuDict))")

                for pizzaSection in menuDict where pizzaSection is [String:AnyObject] {
  //                   print("Found Pizza Section =  \(pizzaSection) that is of type \(type(of:pizzaSection))")
                    for sectionName in pizzaSection.keyEnumerator() where sectionName is String {
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
                    }
  /**
                    guard let objectDict = objectDict as? Dictionary<String, AnyObject> else {
                        completion(ParseError.errorParsingJSON, nil)
                        return
                    }
                    guard let itemSummaryDict = objectDict["object_summary"] as? [String:String] else {
                        completion(ParseError.errorParsingJSON, nil)
                        return
                    }
                    guard let objectType = itemSummaryDict["type"] else {
                        completion(ParseError.errorParsingJSON, nil)
                        return
                    }
                    
                    switch objectType {
                    case  CatalogItem.CatalogItemType.consumerProduct.rawValue:
                        // add a Car catalog object to this catalog
                        guard let carCatalogItem =  ConsumerProductCatalogItem(itemIdentifier:itemIdentifier, objectDict:objectDict) else {
                            completion(ParseError.errorParsingJSON, nil)
                            return
                        }
                        self.pizzas?.append(carCatalogItem)
                        break;
                        
                    case  CatalogItem.CatalogItemType.hardware.rawValue:
                        // add a Computer catalog object to this catalog
                        guard let computerCatalogItem =  HardwareCatalogItem(itemIdentifier:itemIdentifier, objectDict:objectDict) else {
                            completion(ParseError.errorParsingJSON, nil)
                           return
                        }
                        self.pizzas?.append(computerCatalogItem)
                        break;
                        
                    case  CatalogItem.CatalogItemType.animal.rawValue:
                        // add an Animal catalog object to this catalog
                        guard let animalCatalogItem =  AnimalCatalogItem(itemIdentifier:itemIdentifier, objectDict:objectDict) else {
                            completion(ParseError.errorParsingJSON, nil)
                            return
                        }
                        self.pizzas?.append(animalCatalogItem)
                        break;
                        
                    default:
                        break;
                    }
                    */
                }
                completion(nil, self.pizzas)
            }
            catch {
                completion(ParseFoodMenuError.errorParsingFoodMenuJSON, nil)
            }
        }
    }
}
