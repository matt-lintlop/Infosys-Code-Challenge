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
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var milageLabel: UILabel!
    var showStartOfText = false

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
        self.descriptionTextView.text = catalogItem.itemSummary.description
        self.priceLabel.text = catalogItem.price
        self.headerLabel.text = "\(catalogItem.itemSummary.color) \(catalogItem.doors.capitalized)-Door  \(catalogItem.itemSummary.name.capitalized)  \(catalogItem.itemIdentifier.capitalized)"
        self.descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
        self.descriptionTextView.setNeedsDisplay()
        self.showStartOfText = true
   }
}
