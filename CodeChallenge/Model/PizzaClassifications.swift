//
//  PizzaClassification.swift
//  Zume-Code-Challenge
//
//  This class contains the pizza is vegetarian classificastion.
//  Created by Matt Lintlop on 1/27/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

struct PizzaClassifications: Decodable {
    let vegetarian:Bool         // vegetariona pizza flag
 
    init?(withDictionary dict:[String:AnyObject]) {
        guard let vegetarian = dict["vegetarian"] as? Bool else {
            return nil
        }
        self.vegetarian = vegetarian
    }
}
