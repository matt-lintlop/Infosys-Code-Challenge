//
//  ConsumerProductViewController.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/24/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class ConsumerProductViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descreptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var milageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
        
    func setupViewController(with catalogItem:ConsumerProductCatalogItem) {
        self.loadViewIfNeeded()
        self.title = catalogItem.itemIdentifier
        self.milageLabel.text = catalogItem.milage
        self.descreptionTextView.text = catalogItem.objectSummary.description
        self.priceLabel.text = catalogItem.price
        self.headerLabel.text = "\(catalogItem.objectSummary.color) \(catalogItem.doors.capitalized)-Door  \(catalogItem.objectSummary.name.capitalized)  \(catalogItem.itemIdentifier.capitalized)"
    }
        
/*
 // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 */
}
