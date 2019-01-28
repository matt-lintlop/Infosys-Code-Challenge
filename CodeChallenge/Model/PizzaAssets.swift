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

struct PizzaAssets: Decodable {
    let menu:PizzaImageReference                // image of pizza in menu
    let productDetailsPage:PizzaImageReference  // image of product details

    private enum CodingKeys: String, CodingKey {
        case productDetailsPage = "product_details_page"
        case menu
    }
}
