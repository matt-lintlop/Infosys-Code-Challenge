//
//  CarCatalogObject.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import Foundation

// Car Catalog Object
class CarCatalogObject: CatalogObject {
    let doors: String
    let price: String
    let milage: String
    
    private enum Keys: String {
        case doors
        case price
        case milage
    }
    override init?(objectIdentifier: String, objectDict: Dictionary<String, AnyObject>) {
        guard let doors = objectDict[Keys.doors.rawValue] as? String,
              let price = objectDict[Keys.price.rawValue] as? String,
              let milage = objectDict[Keys.milage.rawValue] as? String else {
            return nil
        }
        self.doors = doors
        self.price = price
        self.milage = milage
        super.init(objectIdentifier: objectIdentifier, objectDict: objectDict)
    }
}
