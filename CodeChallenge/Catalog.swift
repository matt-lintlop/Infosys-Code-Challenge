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
    var catalogObjects: [ CatalogItem]?
    
    init() {
        self.catalogObjects = []
    }
    
    func parseJSON(completion: @escaping (Error?, [ CatalogItem]?) -> Void) {
        DispatchQueue.global(qos: .background).async {
            guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
                return
            }
            let url = URL(fileURLWithPath: path)
            guard let jsonData = try? Data(contentsOf: url) else {
                return
            }
            do {
                guard let catalogDict = try JSONSerialization.jsonObject(with: jsonData, options: .allowFragments) as? [String : AnyObject] else {
                    return
                }
                for (itemIdentifier, objectDict) in catalogDict {
                    guard let objectDict = objectDict as? Dictionary<String, AnyObject> else {
                        return
                    }
                    guard let objectSummaryDict = objectDict["object_summary"] as? [String: String] else {
                        continue
                    }
                    guard let objectType = objectSummaryDict["type"] else {
                        continue
                    }
                    
                    switch objectType {
                    case  CatalogItem.CatalogItemType.consumerProduct.rawValue:
                        // add a Car catalog object to this catalog
                        guard let carCatalogItem =  ConsumerProductCatalogItem(itemIdentifier: itemIdentifier, objectDict: objectDict) else {
                            continue
                        }
                        self.catalogObjects?.append(carCatalogItem)
                        break;
                        
                    case  CatalogItem.CatalogItemType.hardware.rawValue:
                        // add a Computer catalog object to this catalog
                        guard let computerCatalogItem =  HardwareCatalogItem(itemIdentifier: itemIdentifier, objectDict: objectDict) else {
                            continue
                        }
                        self.catalogObjects?.append(computerCatalogItem)
                        break;
                        
                    case  CatalogItem.CatalogItemType.animal.rawValue:
                        // add an Animal catalog object to this catalog
                        guard let animalCatalogItem =  AnimalCatalogItem(itemIdentifier: itemIdentifier, objectDict: objectDict) else {
                            continue
                        }
                        self.catalogObjects?.append(animalCatalogItem)
                        break;
                        
                    default:
                        break;
                    }
                }
                completion(nil, self.catalogObjects)
            }
            catch {
                completion(error,nil)
            }
        }
    }
}
