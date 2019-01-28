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
    
    init?(withSectionName sectionName:String, sectionPizzaDicts:[[String:AnyObject]]) {
        self.sectionName = sectionName
        self.sectionPizzas = []
         for pizzaDict in sectionPizzaDicts {
            guard let pizza = Pizza(withDictionary: pizzaDict) else {
                return nil
            }
            self.sectionPizzas?.append(pizza)
        }
    }
}
