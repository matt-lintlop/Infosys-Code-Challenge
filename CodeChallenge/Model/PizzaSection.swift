//
//  PizzaSection.swift
//  Zume-Code-Challenge
//
//  This class has the pizzas for one section.
//
//  Created by Matt Lintlop on 1/27/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

struct PizzaSection {
    let sectionName:String
    let sectionPizzas:[Pizza]?
    
    let sectionsDict:[String:[[String:AnyObject]]]      // pizza section dict (key = section name, value = pizzas in the section)
    
    init?(withDictionary dict:[String:[[String:AnyObject]]]) {
        guard let name = dict.keys.first else {
            return nil
        }
        
        self.sectionsDict = dict
        self.sectionName = name
        self.sectionPizzas = []
        guard let pizzaDicts:[[String:AnyObject]] = dict.values.first else {
            return nil
        }
        for pizzaDict in pizzaDicts {
            guard let pizza = Pizza(withDictionary: pizzaDict) else {
                return nil
            }
            self.sectionPizzas?.append(pizza)
        }
    }
}
