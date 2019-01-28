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
    var pizzaSections:[PizzaSection]?
    var pizzaMenu:[[String:AnyObject]]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let pizzaMenuParser = PizzaMenuParser()
        pizzaMenuParser.downloadAndParsePizzaMenuJSON() { (error, pizzaSections) in
            
            if let error = error {
                print("Error in downloadAndParsePizzaMenuJSON(): \(error.localizedDescription)")
            }
            else {
                self.pizzaSections = pizzaSections
                print("Success in downloadAndParsePizzaMenuJSON() : \(pizzaSections!.count) sections")
            }
            
            DispatchQueue.main.async(execute:{
                if let error = error {
                    let alertController = UIAlertController(title:"Error", message:
                        "Error downloading pizza menu: \(error)", preferredStyle:UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title:"Dismiss", style:UIAlertActionStyle.default,handler:nil))
                    self.present(alertController, animated:true, completion:nil)
                }
                else {
 //                   self.makeSectionsWithPizzas(???)
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
    
    
    // get the pizza section at a given index
    func getPizzaSection(_ section:Int) -> PizzaSection? {
        guard let sectionCount = self.pizzaSections?.count, section < sectionCount else {
            return nil
        }
        
        guard let pizzaSection = self.pizzaSections?[section] else {
            return nil
        }
        return pizzaSection
    }


    // get the name of the section at an index
    func getSectionName(atSection section:Int) -> String? {
        guard let pizzaSection = getPizzaSection(section) else {
            return nil
        }
        print(">>> name of section # \(section) = \(pizzaSection.sectionName)")
        
        return pizzaSection.sectionName
    }

    // get the pizza model object at an index path
    func getPizza(atIndexPath indexPath:IndexPath) -> Pizza? {
        guard let pizzaSection = getPizzaSection(indexPath.section) else {
            return nil
        }
        guard let sectionPizzas = pizzaSection.sectionPizzas else {
            return nil
        }
        guard indexPath.row < sectionPizzas.count else {
            return nil
        }
        return sectionPizzas[indexPath.row]
    }

    // MARK:- Table view data source

    override func numberOfSections(in tableView:UITableView) -> Int {
        guard let sectionCount = pizzaSections?.count else {
            return 0
        }
        print(">>> Total # Sections: \(sectionCount)")
        return sectionCount
    }

    override func tableView(_ tableView:UITableView, numberOfRowsInSection section:Int) -> Int {
        guard let pizzaSection = getPizzaSection(section) else {
            return 0
        }
        guard let sectionPizzas = pizzaSection.sectionPizzas else {
            return 0
        }
        print(">>> Section #\(section) has \(sectionPizzas.count) rows")
        return sectionPizzas.count
    }
    
    override func tableView(_ tableView:UITableView, titleForHeaderInSection section:Int) -> String? {
        return getSectionName(atSection:section)
    }

    override func tableView(_ tableView:UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
        guard let pizza = getPizza(atIndexPath:indexPath) else {
            return tableView.dequeueReusableCell(withIdentifier:"PizzaCell")!
        }
        let classificationString = pizza.classificationString()
        
        if (classificationString != nil) && (classificationString!.isEmpty == false) {
            let cell = tableView.dequeueReusableCell(withIdentifier:"PizzaDetailCell", for:indexPath)
            cell.textLabel?.text = pizza.name
            cell.detailTextLabel?.text = classificationString
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier:"PizzaCell", for:indexPath)
            cell.textLabel?.text = pizza.name
            return cell
        }
  
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
