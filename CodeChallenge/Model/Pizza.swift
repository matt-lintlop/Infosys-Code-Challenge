//
//  Pizza.swift
//  Zume-Code-Challenge
//
//  This class contains the data for one pizza.
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import UIKit

// Catalog Item Delegate protocol
protocol PizzaDelegate {
    func pizza(_ pizza:Pizza, didLoadImageImage image:UIImage?, withError error:Error?)
}

// Catalog Item class
class  Pizza  {
    var id:String = ""                              // pizza id
    var name:String = ""                            // name of pizza
    var price:String = ""                           // price of pizza
    let menuDescription:String = ""                 // pizza menu description
    var assets:PizzaAssets?                         // pizza assets (images)
    var toppings:[PizzaTopping]?                    // pizza toppings
    var classifications:PizzaClassifications?       // pizza classifications
    var indexPath:IndexPath?                        // index path of associated table view cell
    var delegate:PizzaDelegate?                     // delegate
 
    private enum DictionaryKeys: String {
        case id
        case name
        case price
        case menuDescription = "menu_description"
        case classifications
        case assets
        case toppings
    }
    
    init?(withDictionary dict:[String:AnyObject]) {

    }
}
