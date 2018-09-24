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
    var catalogObjects: [CatalogObject]?

    enum CatalogObjectType: String {
        case consumerProduct = "consumer product"
        case hardware
        case animal
    }
    
    init() {
        self.catalogObjects = []
    }
    
    func parseJSON(completion: @escaping (Error?, [CatalogObject]?) -> Void) {
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
                for (objectIdentifier, objectDict) in catalogDict {
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
                    case CatalogObjectType.consumerProduct.rawValue:
                        // add a Car catalog object to this catalog
                        guard let carCatalogObject =  CarCatalogObject(objectIdentifier: objectIdentifier, objectDict: objectDict) else {
                            continue
                        }
                        self.catalogObjects?.append(carCatalogObject)
                        break;
                        
                    case CatalogObjectType.hardware.rawValue:
                        // add a Computer catalog object to this catalog
                        guard let computerCatalogObject =  ComputerCatalogObject(objectIdentifier: objectIdentifier, objectDict: objectDict) else {
                            continue
                        }
                        self.catalogObjects?.append(computerCatalogObject)
                        break;
                        
                    case CatalogObjectType.animal.rawValue:
                        // add an Animal catalog object to this catalog
                        guard let animalCatalogObject =  PetCatalogObject(objectIdentifier: objectIdentifier, objectDict: objectDict) else {
                            continue
                        }
                        self.catalogObjects?.append(animalCatalogObject)
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
