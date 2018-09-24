//
//  CatalogTableViewController.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/23/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class CatalogTableViewController:UITableViewController, CatalogItemDelegate {
    var catalogItems:[CatalogItem]?
    var sectionNames:[String] = []
    var sectionCatalogItems:[[CatalogItem]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let catalog = Catalog()
        catalog.parseJSON { (error, catalogObjects) in
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func makeSectionsWithCatalogItems(_ catalogItems:[CatalogItem]) {
        
        var sectionsDict:[String:[CatalogItem]] = [:]
        self.sectionNames = []
        self.sectionCatalogItems = []

        for catalogItem in catalogItems {
            let type = catalogItem.objectSummary.type
            if var sectionCatalogItems = sectionsDict[type] {
                sectionCatalogItems.append(catalogItem)
                sectionsDict[type] = sectionCatalogItems
            }
            else {
                sectionsDict[type] = [catalogItem]
            }
        }
        
        for (sectionName, sectionCatalogItems) in sectionsDict {
            self.sectionNames.append(sectionName)
            self.sectionCatalogItems.append(sectionCatalogItems)
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
    func getCatalogItem(atIndexPath indexPath:IndexPath) -> CatalogItem? {
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
        return cell
    }

    override func tableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath) {
        guard let catalogItem = getCatalogItem(atIndexPath:indexPath) else {
            return
        }
        switch (catalogItem.objectSummary.type) {
            
        case  CatalogItem.CatalogItemType.consumerProduct.rawValue:
            showItemViewController(withConsumerProductCatalogItem:catalogItem as! ConsumerProductCatalogItem)
            
        case  CatalogItem.CatalogItemType.hardware.rawValue:
            showViewController(withHardwareCatalogItem:catalogItem as! HardwareCatalogItem)

        case  CatalogItem.CatalogItemType.animal.rawValue:
            showViewController(withAnimalCatalogItem:catalogItem as! AnimalCatalogItem)

        default:
            return
        }
    }
    
    func showItemViewController(withConsumerProductCatalogItem:ConsumerProductCatalogItem) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:"ConsumerProductViewController")
        self.navigationController?.pushViewController(viewController, animated:true)
    }
    
    func showViewController(withHardwareCatalogItem:HardwareCatalogItem) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:"HardwareViewController")
        self.navigationController?.pushViewController(viewController, animated:true)
    }
    
    func showViewController(withAnimalCatalogItem:AnimalCatalogItem) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let viewController = storyboard.instantiateViewController(withIdentifier:"AnimalViewController")
        self.navigationController?.pushViewController(viewController, animated:true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView:UITableView, canEditRowAt indexPath:IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView:UITableView, commit editingStyle:UITableViewCellEditingStyle, forRowAt indexPath:IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at:[indexPath], with:.fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView:UITableView, moveRowAt fromIndexPath:IndexPath, to:IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView:UITableView, canMoveRowAt indexPath:IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK:- Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue:UIStoryboardSegue, sender:Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK - CatalogItemDelegate
    
    func catalogItem(_ catalogItem: CatalogItem, atIndexPath indexPath: (IndexPath), didLoadImageImage image: UIImage?, withError error: Error?) {
        print("Did finish loading image at index path:\(indexPath) with error:\(error)")
    }
}
