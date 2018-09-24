//
//  CatalogTableViewController.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/23/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class CatalogTableViewController: UITableViewController {
    
    var catalogItems: [CatalogItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let catalog = Catalog()
        catalog.parseJSON { (error, catalogObjects) in
            DispatchQueue.main.async(execute: {
                if let error = error {
                    let alertController = UIAlertController(title: "Error", message:
                        "Error Parsing Catalog: \(error)", preferredStyle: UIAlertControllerStyle.alert)
                    alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
                    self.present(alertController, animated: true, completion: nil)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeSectionsWithCatalogItems(_ catalogItems: [CatalogItem]) {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let catalogObjects = self.catalogItems else {
            return 0
        }
        if (catalogObjects.count >= 1) {
            return 1
        }
        else {
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let catalogObjects = self.catalogItems else {
            return 0
        }
        return catalogObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let catalogItem = self.catalogItems?[indexPath.row] else {
            return tableView.dequeueReusableCell(withIdentifier: "CatalogItemCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatalogItemCell", for: indexPath)
        cell.textLabel?.text = catalogItem.itemIdentifier
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let catalogItem = self.catalogItems?[indexPath.row] else {
            return
        }
        
        switch (catalogItem.objectSummary.type) {
            
        case  CatalogItem.CatalogItemType.consumerProduct.rawValue:
            showItemViewController(withConsumerProductCatalogItem:catalogItem as! ConsumerProductCatalogItem)
            
        case  CatalogItem.CatalogItemType.hardware.rawValue:
            showViewController(withHardwareCatalogItem: catalogItem as! HardwareCatalogItem)

        case  CatalogItem.CatalogItemType.animal.rawValue:
            showViewController(withAnimalCatalogItem: catalogItem as! AnimalCatalogItem)

        default:
            return
        }
    }
    
    func showItemViewController(withConsumerProductCatalogItem: ConsumerProductCatalogItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "ConsumerProductViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showViewController(withHardwareCatalogItem: HardwareCatalogItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HardwareViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func showViewController(withAnimalCatalogItem: AnimalCatalogItem) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "AnimalViewController")
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
