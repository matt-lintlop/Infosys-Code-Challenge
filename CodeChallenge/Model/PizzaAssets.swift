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
    let menu:PizzaImageReference?                   // image of pizza in menu
    let productDetailsPage:PizzaImageReference?      // image of product details

    private enum DictionaryKeys: String {
        case productDetailsPage = "product_details_page"
        case menu
    }

    init?(withDictionary dict:[String:AnyObject]) {
        guard let menuAssetDict = dict["menu"] as? [String:AnyObject] else {
            return nil
        }
        self.menu = PizzaImageReference(withDictionary: menuAssetDict)

        guard let productDetailsAssetDict = dict["product_details_page"] as? [String:AnyObject] else {
            return nil
        }
        self.productDetailsPage = PizzaImageReference(withDictionary: productDetailsAssetDict)
    }
}
