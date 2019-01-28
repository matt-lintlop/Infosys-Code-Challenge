//
//  PizzaTableViewController.swift
//  Zume-Code-Challenge
//
//  This class is a table view with several sections of pizzs.
//
//  Created by Matt Lintlop on 1/24/19.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import UIKit

class PizzaTableViewController:UITableViewController, PizzaDelegate {
    var pizzas:[Pizza]?
    var sectionNames:[String] = []
    var sectionPizzas:[[Pizza]] = []
    var pizzaMenu:[[String:AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pizzaMenuParser = PizzaMenuParser()
        pizzaMenuParser.downloadAndParsePizzaMenuJSON() { (error, pizzaMenu) in
            
            if let error = error {
                print("Error in downloadAndParsePizzaMenuJSON(): \(error.localizedDescription)")
            }
            else {
                self.pizzaMenu = pizzaMenu
                print("Success in downloadAndParsePizzaMenuJSON() : pizzaMenu = \(String(describing: pizzaMenu))")
            }
            
            DispatchQueue.main.async(execute:{
                if let error = error {
                    let alertController = UIAlertController(title:"Error", message:
                        "Error downloading pizza menu: \(error)", preferredStyle:UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title:"Dismiss", style:UIAlertActionStyle.default,handler:nil))
                    self.present(alertController, animated:true, completion:nil)
                }
                else {
                    guard let pizzas = self.pizzas else {
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
    
    func makeSectionsWithPizzas(_ pizzas:[Pizza]) {
//        var sectionsDict:[String:[Pizza]] = [:]
//        self.sectionNames = []
//        self.sectionPizzas = []
//
//        for pizza in pizzas {
//            pizza.delegate = self
//            let type = pizza.pizzaSummary.type.capitalized
//            if var sectionPizzas = sectionsDict[type] {
//                sectionPizzas.append(pizza)
//                sectionsDict[type] = sectionPizzas
//            }
//            else {
//                sectionsDict[type] = [pizza]
//            }
//        }
//        let sortedSectionNames = sectionsDict.keys.sorted()
//        for sectionName in sortedSectionNames {
//            self.sectionNames.append(sectionName)
//            let unsortedSectionPizzas = sectionsDict[sectionName]!
//            let sortedSectionPizzas = unsortedSectionPizzas.sorted { (pizza1, pizza2) -> Bool in
//                return pizza1.pizzaIdentifier < pizza2.pizzaIdentifier
//            }
//            self.sectionPizzas.append(sortedSectionPizzas)
//        }
//        for (sectionNunber, _) in self.sectionNames.enumerated() {
//            let sectionPizzas = self.sectionPizzas[sectionNunber]
//            for (rowNumber, pizza) in sectionPizzas.enumerated() {
//                pizza.indexPath = IndexPath(row:rowNumber, section:sectionNunber)
//            }
//        }
    }

    // get the name of the section at an index path
    func getSectionName(atSection section:Int) -> String {
        guard section < sectionNames.count else {
            return ""
        }
        return sectionNames[section]
    }

    // get the pizza model object at an index path
    func getPizza(atIndexPath indexPath:IndexPath) -> Pizza? {
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
        guard let pizza = getPizza(atIndexPath:indexPath) else {
            return tableView.dequeueReusableCell(withIdentifier:"CatalogItemCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier:"CatalogItemCell", for:indexPath)
        cell.textLabel?.text = pizza.name
        
        return cell
    }

    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath) {
        guard let pizza = getPizza(atIndexPath:indexPath) else {
            return
        }
    }
    
    // MARK:- Catalog Item View Controllers
    
    func showPizzaDetailViewController(withPizza pizza:Pizza) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        guard let viewController:PizzaDetailViewController = storyboard.instantiateViewController(withIdentifier:"PizzaDetailViewController") as? PizzaDetailViewController else {
            return
        }
        viewController.setupViewController(withPizza:pizza)
        self.navigationController?.pushViewController(viewController, animated:true)
    }
   
    // MARK - PizzaDelegate
    func pizza(_ pizza: Pizza, didLoadImageImage image: UIImage?, withError error: Error?) {
        guard let indexPath = pizza.indexPath, error == nil else {
            return
        }
        DispatchQueue.main.async(execute:{
            self.tableView.reloadRows(at: [indexPath], with: .none)
        })
    }
 }
