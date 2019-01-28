//
//  PizzaClassification.swift
//  Zume-Code-Challenge
//
//  This class contains the pizza is vegetarian classificastion.
//  Created by Matt Lintlop on 1/27/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

struct PizzaClassifications {
    let vegetarian:Bool         // vegetariona pizza flag
    let spicy:Bool              // vegetariona pizza flag
    let glutonFree:Bool         // vegetariona pizza flag

    private enum DictionaryKeys: String {
        case vegetarian
        case spicy
        case glutonFree = "gluten_free"
    }

    init?(withDictionary dict:[String:AnyObject]) {
        guard let vegetarian = dict[DictionaryKeys.vegetarian.rawValue] as? Bool else {
            return nil
        }
        self.vegetarian = vegetarian
        
        guard let spicy = dict[DictionaryKeys.spicy.rawValue] as? Bool else {
            return nil
        }
        self.spicy = spicy
        
        guard let glutonFree = dict[DictionaryKeys.glutonFree.rawValue] as? Bool else {
            return nil
        }
        self.glutonFree = glutonFree

   }
    
    
    // Get the text for this classification as a string
    func toString() -> String? {
        var string = ""
        
        if (self.vegetarian) {
            string = "Vegetarian"
        }
        else if (self.spicy) {
            if !string.isEmpty {
                string += ", "
            }
            string += "Spicy"
        }
        else if (self.glutonFree) {
            if !string.isEmpty {
                string += ", "
            }
            string += "Gluton Free"
        }
        return string
    }
}
