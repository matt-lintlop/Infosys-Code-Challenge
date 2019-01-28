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
    
    private enum DictionaryKeys: String {
        case id
        case name
        case description
        case assets
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
        self.description = dict[DictionaryKeys.description.rawValue] as? String
        if let assetsDict = dict[DictionaryKeys.assets.rawValue] as? [String:AnyObject] {
            guard let assets = PizzaAssets(withDictionary: assetsDict) else {
                return nil
            }
            self.assets = assets
        }
        return nil
    }
}

