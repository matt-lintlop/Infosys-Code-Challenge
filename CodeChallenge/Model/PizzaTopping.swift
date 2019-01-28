//
//  PizzaTopping.swift
//  Zume-Code-Challenge
//
//  This class contains the data for one pizza topping.
//
//  Created by Matt Lintlop on 1/26/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

struct PizzaTopping: Decodable {
    let id:Int                      // topping id
    let name:String                 // name of topping
    var description:String?         // description of topping
    var assets:PizzaAssets?         // asset with url of topping image
}

