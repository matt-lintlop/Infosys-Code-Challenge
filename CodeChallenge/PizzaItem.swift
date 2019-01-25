//
//  CatalogItem.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/22/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

// Catalog Item Delegate protocol
protocol CatalogItemDelegate {
    func catalogItem(_ catalogItem:PizzaItem, didLoadImageImage image:UIImage?, withError error:Error?)
}

// Catalog Item class
class  PizzaItem  {
    var itemIdentifier:String                           // catalog item identifier
    var itemSummary:CatalogItemSummary                  // catalog item summary dictionary
    var indexPath:IndexPath?                            // index path of associated table view cell
    var delegate:CatalogItemDelegate?                   // delegate
    
    enum  CatalogItemType:String {
        case consumerProduct = "consumer product"
        case hardware
        case animal
    }

    private enum DictionaryKeys:String {
        case itemSummary = "object_summary"
    }
    
    init?(itemIdentifier:String, objectDict:Dictionary<String, AnyObject>) {
        self.itemIdentifier = itemIdentifier.capitalized
        guard let itemSummaryDict = objectDict[DictionaryKeys.itemSummary.rawValue] as? Dictionary<String, String> else {
            return nil
        }
        guard let summary =   CatalogItemSummary(withDictionary:itemSummaryDict) else {
            return nil
        }
        self.itemSummary = summary
   }
 }
