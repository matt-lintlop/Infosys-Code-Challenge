//
//  PizzaAsset.swift
//  Zume-Code-Challenge
//
//  This class has the pizza assets that are images.
//
//  Created by Matt Lintlop on 1/26/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import Foundation

struct PizzaAssets {
    var menu:PizzaImageReference?                   // image of pizza in menu
    var productDetailsPage:PizzaImageReference?      // image of product details

    private enum DictionaryKeys: String {
        case productDetailsPage = "product_details_page"
        case menu
    }

    init?(withDictionary dict:[String:AnyObject]) {
        
        if let menuAssetDict = dict[DictionaryKeys.menu.rawValue] as? [String:AnyObject] {
            guard let menu = PizzaImageReference(withDictionary: menuAssetDict) else {
                return nil
            }
            self.menu = menu
        }
        else {
            return nil
        }
        if let productDetailsAssetDict = dict[DictionaryKeys.productDetailsPage.rawValue] as? [String:AnyObject] {
            guard let productDetailsPage = PizzaImageReference(withDictionary: productDetailsAssetDict) else {
                return nil
            }
            self.productDetailsPage = productDetailsPage
        }
        else {
            return nil
        }

        
        guard let productDetailsAssetDict = dict["product_details_page"] as? [String:String] else {
            return nil
        }
        self.productDetailsPage = PizzaImageReference(withDictionary: productDetailsAssetDict as [String : AnyObject])
    }
}
