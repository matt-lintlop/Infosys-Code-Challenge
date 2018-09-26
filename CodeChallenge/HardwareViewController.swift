//
//  HardwareViewController.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/24/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class HardwareViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
    
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

    func setupViewController(with catalogItem:HardwareCatalogItem) {
        self.loadViewIfNeeded()
        self.title = catalogItem.itemIdentifier
        self.purchaseDateLabel.text = catalogItem.purchaseDate
        self.descriptionTextView.text = catalogItem.itemSummary.description
        self.colorLabel.text = catalogItem.itemSummary.color
        self.headerLabel.text = "\(catalogItem.itemSummary.name.capitalized) The \(catalogItem.itemIdentifier.capitalized)"
        self.descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
        self.descriptionTextView.setNeedsDisplay()
        if let image = catalogItem.image {
            self.imageView.alpha = 0.0
            UIView.animate(withDuration: 0.5, animations: {
                    self.imageView.image = image
                    self.imageView.alpha = 1.0
          })
        }
    }
}
