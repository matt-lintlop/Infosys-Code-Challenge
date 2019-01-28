//
//  PizzaMenu.swift
//  Zume-Code-Challenge
//
//  This class has a list multiple named sections of pizzas.
//
//  Created by Matt Lintlop on 1/27/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

struct PizzaMenu:Decodable {
    var sections:[[String:PizzaSection]]?        // list section dictionaries [key = section name: value = section pizzas]
}

