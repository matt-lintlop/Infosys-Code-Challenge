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
    var catalogObjects:[CatalogItem]?
    var sectionNames:[String]?
    var catalogSectionDict:[String:[CatalogItem]]?

    enum ParseError:Error {
        case errorParsingJSON
    }
    
    init() {
        self.catalogObjects = []
    }
 
    func parseJSON(completion:@escaping (Error?, [CatalogItem]?) -> Void) {
        DispatchQueue.global(qos:.background).async {
             do {
                // TODO: Testing load the pizza data
                guard let path = Bundle.main.path(forResource:"pizza", ofType:"json") else {
                    completion(ParseError.errorParsingJSON, nil)
                    return
                }
                let url = URL(fileURLWithPath:path)
                let jsonData = try Data(contentsOf:url)
                let menuDict = try JSONSerialization.jsonObject(with:jsonData, options:.allowFragments) as! [AnyObject]

                   print("Found the Menu Dictionary: \(menuDict) that is of type \(type(of:menuDict))")

                for pizzaSection in menuDict where pizzaSection is [String:AnyObject] {
  //                   print("Found Pizza Section =  \(pizzaSection) that is of type \(type(of:pizzaSection))")
                    for sectionName in pizzaSection.keyEnumerator() where sectionName is String {
                        print("section name = \(sectionName)")
                        guard let sectionPizzas = pizzaSection[sectionName] as? [AnyObject] else {
                            continue
                        }
                        print("section pizzas = has \(sectionPizzas.count) pizzas")
                        
//                        for pizza in sectionPizzas {
//                            print("Found A Pizza: \(pizza)")
//                        }
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
                        self.catalogObjects?.append(carCatalogItem)
                        break;
                        
                    case  CatalogItem.CatalogItemType.hardware.rawValue:
                        // add a Computer catalog object to this catalog
                        guard let computerCatalogItem =  HardwareCatalogItem(itemIdentifier:itemIdentifier, objectDict:objectDict) else {
                            completion(ParseError.errorParsingJSON, nil)
                           return
                        }
                        self.catalogObjects?.append(computerCatalogItem)
                        break;
                        
                    case  CatalogItem.CatalogItemType.animal.rawValue:
                        // add an Animal catalog object to this catalog
                        guard let animalCatalogItem =  AnimalCatalogItem(itemIdentifier:itemIdentifier, objectDict:objectDict) else {
                            completion(ParseError.errorParsingJSON, nil)
                            return
                        }
                        self.catalogObjects?.append(animalCatalogItem)
                        break;
                        
                    default:
                        break;
                    }
                    */
                }
                completion(nil, self.catalogObjects)
            }
            catch {
                completion(ParseError.errorParsingJSON, nil)
            }
        }
    }
}
