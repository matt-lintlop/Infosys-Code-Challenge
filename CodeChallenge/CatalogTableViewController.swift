//
//  CatalogTableViewController.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/23/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class CatalogTableViewController:UITableViewController, CatalogItemDelegate {
    var catalogItems:[PizzaItem]?
    var sectionNames:[String] = []
    var sectionCatalogItems:[[PizzaItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pizzaMenu = PizzaMenu()
        pizzaMenu.downloadedPizzaJSON() { (error, catalogObjects) in
            DispatchQueue.main.async(execute:{
                if let error = error {
                    let alertController = UIAlertController(title:"Error", message:
                        "Error Parsing Catalog:\(error)", preferredStyle:UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title:"Dismiss", style:UIAlertActionStyle.default,handler:nil))
                    self.present(alertController, animated:true, completion:nil)
                }
                else {
                    guard let catalogObjects = catalogObjects else {
                        return
                    }
                    self.catalogItems = catalogObjects
                    self.makeSectionsWithCatalogItems(catalogObjects)
                    self.tableView.reloadData()
                }
            })
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeSectionsWithCatalogItems(_ catalogItems:[PizzaItem]) {
        var sectionsDict:[String:[PizzaItem]] = [:]
        self.sectionNames = []
        self.sectionCatalogItems = []

        for catalogItem in catalogItems {
            catalogItem.delegate = self
            let type = catalogItem.itemSummary.type.capitalized
            if var sectionCatalogItems = sectionsDict[type] {
                sectionCatalogItems.append(catalogItem)
                sectionsDict[type] = sectionCatalogItems
            }
            else {
                sectionsDict[type] = [catalogItem]
            }
        }
        let sortedSectionNames = sectionsDict.keys.sorted()
        for sectionName in sortedSectionNames {
            self.sectionNames.append(sectionName)
            let unsortedSectionCatalogItems = sectionsDict[sectionName]!
            let sortedSectionCatalogItems = unsortedSectionCatalogItems.sorted { (catalogItem1, catalogItem2) -> Bool in
                return catalogItem1.itemIdentifier < catalogItem2.itemIdentifier
            }
            self.sectionCatalogItems.append(sortedSectionCatalogItems)
        }
        for (sectionNunber, _) in self.sectionNames.enumerated() {
            let sectionCatalogObjects = self.sectionCatalogItems[sectionNunber]
            for (rowNumber, catalogObject) in sectionCatalogObjects.enumerated() {
                catalogObject.indexPath = IndexPath(row:rowNumber, section:sectionNunber)
            }
        }
    }

    // get the name of the section at an index path
    func getSectionName(atSection section:Int) -> String {
        guard section < sectionNames.count else {
            return ""
        }
        return sectionNames[section]
    }

    // get the catalog items in section at an index path
    func getCatalogItem(atIndexPath indexPath:IndexPath) -> PizzaItem? {
        guard indexPath.section < self.sectionCatalogItems.count else {
            return nil
        }
        let sectionCatalogItems = self.sectionCatalogItems[indexPath.section]
        return sectionCatalogItems[indexPath.row]
    }

    // MARK:- Table view data source

    override func numberOfSections(in tableView:UITableView) -> Int {
       return sectionNames.count
    }

    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        let sectionObjects = sectionCatalogItems[section]
        return sectionObjects.count
    }
    
    override func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String? {
        return getSectionName(atSection:section)
    }

    override func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        guard let catalogItem = getCatalogItem(atIndexPath:indexPath) else {
            return tableView.dequeueReusableCell(withIdentifier:"CatalogItemCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier:"CatalogItemCell", for:indexPath)
        cell.textLabel?.text = catalogItem.itemIdentifier
        
        if let visualCatalogItem = catalogItem as? VisualCatalogItem {
            cell.imageView?.image = visualCatalogItem.image
        }
        return cell
    }

    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath) {
        guard let catalogItem = getCatalogItem(atIndexPath:indexPath) else {
            return
        }
        switch (catalogItem.itemSummary.type) {
        case  PizzaItem.CatalogItemType.consumerProduct.rawValue:
            showViewController(withtCatalogItem:catalogItem as! ConsumerProductCatalogItem)
            
        case  PizzaItem.CatalogItemType.hardware.rawValue:
            showViewController(withtCatalogItem:catalogItem as! HardwareCatalogItem)

        case  PizzaItem.CatalogItemType.animal.rawValue:
            showViewController(withtCatalogItem:catalogItem as! AnimalCatalogItem)
        default:
            return
        }
    }
    
    // MARK:- Catalog Item View Controllers
    
    func showViewController(withtCatalogItem consumerProductCatalogItem:ConsumerProductCatalogItem) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        guard let viewController:ConsumerProductViewController = storyboard.instantiateViewController(withIdentifier:"ConsumerProductViewController") as? ConsumerProductViewController else {
            return
        }
        viewController.setupViewController(with:consumerProductCatalogItem)
        self.navigationController?.pushViewController(viewController, animated:true)
    }
   
    func showViewController(withtCatalogItem catalogItem:HardwareCatalogItem) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:"HardwareViewController") as? HardwareViewController else {
            return
        }
        viewController.setupViewController(with:catalogItem)
        self.navigationController?.pushViewController(viewController, animated:true)
    }
    
    func showViewController(withtCatalogItem catalogItem:AnimalCatalogItem) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:"AnimalViewController") as? AnimalViewController else {
            return
        }
        viewController.setupViewController(with:catalogItem)
        self.navigationController?.pushViewController(viewController, animated:true)
    }
    
    // MARK - CatalogItemDelegate
    func catalogItem(_ catalogItem: PizzaItem, didLoadImageImage image: UIImage?, withError error: Error?) {
        guard let indexPath = catalogItem.indexPath, error == nil else {
            return
        }
        DispatchQueue.main.async(execute:{
            self.tableView.reloadRows(at: [indexPath], with: .none)
        })
    }
 }
