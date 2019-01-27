//
//  Pizza.swift
//  Zume-Code-Challenge
//
//  This class is a model object with the data for one pizza.
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
    var pizzaIdentifier:String                          // pizza identifier
    var pizzaSummary:PizzasSummary                      // pizza summary dictionary
    var indexPath:IndexPath?                            // index path of associated table view cell
    var delegate:PizzaDelegate?                         // delegate
 
    private enum DictionaryKeys:String {
        case pizzaSummary = "object_summary"
    }
    
    init?(pizzaIdentifier:String, objectDict:Dictionary<String, AnyObject>) {
        self.pizzaIdentifier = pizzaIdentifier.capitalized
        guard let pizzaSummaryDict = objectDict[DictionaryKeys.pizzaSummary.rawValue] as? Dictionary<String, String> else {
            return nil
        }
        guard let summary =   PizzasSummary(withDictionary:pizzaSummaryDict) else {
            return nil
        }
        self.pizzaSummary = summary
   }
 }
