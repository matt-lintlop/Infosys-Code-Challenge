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

    private enum DictionaryKeys: String {
        case sectionsDict = ""
    }
    
    init?(withDictionary dict:[String:[[String:AnyObject]]]) {
        guard let sectionName = dict.keys.first else {
            return nil
        }
        self.sectionsDict = dict
        self.sectionName = sectionName
        self.sectionPizzas = nil
    }
}
