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

struct PizzaTopping  {
    let id:Int                      // topping id
    let name:String                 // name of topping
    var description:String?         // description of topping
    var assets:PizzaAssets?         // asset with url of topping image
    
    init?(withDictionary dict:[String:AnyObject]) {
        guard let id = dict["id"] as? Int else {
            return nil
        }
        self.id = id

        guard let name = dict["name"] as? String else {
            return nil
        }
        self.name = name
        
        self.description = dict["description"] as? String

        if let assets = dict["assets"] as? [[String:String]] {

        }
        self.description = dict["description"] as? String
        return nil
    }
}

