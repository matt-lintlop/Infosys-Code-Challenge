//
//  CatalogTableViewController.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/23/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class CatalogTableViewController:UITableViewController, CatalogItemDelegate {
    var pizzas:[PizzaItem]?
    var sectionNames:[String] = []
    var sectionPizzas:[[PizzaItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pizzaMenu = PizzaMenu()
        pizzaMenu.downloadedPizzaJSON() { (error, pizzas) in
            DispatchQueue.main.async(execute:{
                if let error = error {
                    let alertController = UIAlertController(title:"Error", message:
                        "Error Parsing Catalog:\(error)", preferredStyle:UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title:"Dismiss", style:UIAlertActionStyle.default,handler:nil))
                    self.present(alertController, animated:true, completion:nil)
                }
                else {
                    guard let pizzas = pizzas else {
                        return
                    }
                    self.pizzas = pizzas
                    self.makeSectionsWithPizzas(pizzas)
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
    
    func makeSectionsWithPizzas(_ pizzas:[PizzaItem]) {
        var sectionsDict:[String:[PizzaItem]] = [:]
        self.sectionNames = []
        self.sectionPizzas = []

        for pizza in pizzas {
            pizza.delegate = self
            let type = pizza.itemSummary.type.capitalized
            if var sectionPizzas = sectionsDict[type] {
                sectionPizzas.append(pizza)
                sectionsDict[type] = sectionPizzas
            }
            else {
                sectionsDict[type] = [pizza]
            }
        }
        let sortedSectionNames = sectionsDict.keys.sorted()
        for sectionName in sortedSectionNames {
            self.sectionNames.append(sectionName)
            let unsortedSectionPizzas = sectionsDict[sectionName]!
            let sortedSectionPizzas = unsortedSectionPizzas.sorted { (pizza1, pizza2) -> Bool in
                return pizza1.itemIdentifier < pizza2.itemIdentifier
            }
            self.sectionPizzas.append(sortedSectionPizzas)
        }
        for (sectionNunber, _) in self.sectionNames.enumerated() {
            let sectionpizzas = self.sectionPizzas[sectionNunber]
            for (rowNumber, catalogObject) in sectionpizzas.enumerated() {
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
        guard indexPath.section < self.sectionPizzas.count else {
            return nil
        }
        let sectionPizzas = self.sectionPizzas[indexPath.section]
        return sectionPizzas[indexPath.row]
    }

    // MARK:- Table view data source

    override func numberOfSections(in tableView:UITableView) -> Int {
       return sectionNames.count
    }

    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        let sectionObjects = sectionPizzas[section]
        return sectionObjects.count
    }
    
    override func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String? {
        return getSectionName(atSection:section)
    }

    override func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        guard let pizza = getCatalogItem(atIndexPath:indexPath) else {
            return tableView.dequeueReusableCell(withIdentifier:"CatalogItemCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier:"CatalogItemCell", for:indexPath)
        cell.textLabel?.text = pizza.itemIdentifier
        
        if let visualCatalogItem = pizza as? VisualCatalogItem {
            cell.imageView?.image = visualCatalogItem.image
        }
        return cell
    }

    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath) {
        guard let pizza = getCatalogItem(atIndexPath:indexPath) else {
            return
        }
        switch (pizza.itemSummary.type) {
        case  PizzaItem.CatalogItemType.consumerProduct.rawValue:
            showViewController(withtCatalogItem:pizza as! ConsumerProductCatalogItem)
            
        case  PizzaItem.CatalogItemType.hardware.rawValue:
            showViewController(withtCatalogItem:pizza as! HardwareCatalogItem)

        case  PizzaItem.CatalogItemType.animal.rawValue:
            showViewController(withtCatalogItem:pizza as! AnimalCatalogItem)
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
   
    func showViewController(withtCatalogItem pizza:HardwareCatalogItem) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:"HardwareViewController") as? HardwareViewController else {
            return
        }
        viewController.setupViewController(with:pizza)
        self.navigationController?.pushViewController(viewController, animated:true)
    }
    
    func showViewController(withtCatalogItem pizza:AnimalCatalogItem) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier:"AnimalViewController") as? AnimalViewController else {
            return
        }
        viewController.setupViewController(with:pizza)
        self.navigationController?.pushViewController(viewController, animated:true)
    }
    
    // MARK - CatalogItemDelegate
    func pizza(_ pizza: PizzaItem, didLoadImageImage image: UIImage?, withError error: Error?) {
        guard let indexPath = pizza.indexPath, error == nil else {
            return
        }
        DispatchQueue.main.async(execute:{
            self.tableView.reloadRows(at: [indexPath], with: .none)
        })
    }
 }
