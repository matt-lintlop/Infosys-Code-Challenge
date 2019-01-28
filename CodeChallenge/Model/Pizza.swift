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
    var id:Int                                   // pizza id
    var name:String                                 // name of pizza
    var price:String?                               // price of pizza
    let menuDescription:String?                     // pizza menu description
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
        guard let id = dict[DictionaryKeys.id.rawValue] as? Int else {
            return nil
        }
        self.id = id
        
        guard let name = dict[DictionaryKeys.name.rawValue] as? String else {
            return nil
        }
        self.name = name
        self.price = dict[DictionaryKeys.price.rawValue] as? String
        self.menuDescription = dict[DictionaryKeys.menuDescription.rawValue] as? String
        
        if let classificationsDict = dict[DictionaryKeys.classifications.rawValue] as? [String:AnyObject] {
            self.classifications = PizzaClassifications(withDictionary: classificationsDict)
        }
        
        if let assetsDict = dict[DictionaryKeys.assets.rawValue] as? [String:AnyObject] {
            self.assets = PizzaAssets(withDictionary: assetsDict)
        }
        
        self.toppings = []
        if let toppingsDict = dict[DictionaryKeys.toppings.rawValue] as? [String:AnyObject],
            let topping = PizzaTopping(withDictionary: toppingsDict) {
            self.toppings?.append(topping)
        }
    }
}
