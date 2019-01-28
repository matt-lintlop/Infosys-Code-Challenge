//
//  PizzaImageReference.swift
//  Zume-Code-Challenge
//
//  This class has the url on an image used for an image of the pizza in the menu ir
//  for a pizza topping.
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

// Image Reference
struct PizzaImageReference: Decodable {
    let url:String                          // image url
    
    init?(withDictionary dict:[String:AnyObject]) {
        guard let url = dict["url"] as? String else {
            return nil
        }
        self.url = url
    }
}
