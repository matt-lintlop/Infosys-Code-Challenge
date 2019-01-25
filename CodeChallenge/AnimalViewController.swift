//
//  AnimalViewController.swift
//  Zume-Code-Challenge
//
//  Created by Matt Lintlop on 9/24/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import UIKit

class AnimalViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var favoriteToyLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var colorLabel: UILabel!
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

    func setupViewController(with pizza:AnimalCatalogItem) {
        self.loadViewIfNeeded()
        self.title = pizza.itemIdentifier
        self.ageLabel.text = pizza.age
        self.favoriteToyLabel.text = pizza.favoriteToy
        self.descriptionTextView.text = pizza.itemSummary.description
        self.colorLabel.text = pizza.itemSummary.color
        self.headerLabel.text = "\(pizza.itemSummary.name.capitalized) The \(pizza.itemIdentifier.capitalized)"
       
        self.descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
        self.descriptionTextView.setNeedsDisplay()
        self.descriptionTextView.setNeedsLayout()
        self.descriptionTextView.layoutIfNeeded()
        
        if let image = pizza.image {
            self.imageView.alpha = 0.0
            UIView.animate(withDuration: 0.5, animations: {
                    self.imageView.image = image
                    self.imageView.alpha = 1.0
            })
        }
        self.showStartOfText = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (self.showStartOfText) {
            self.showStartOfText = false
            self.descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
            self.descriptionTextView.setNeedsDisplay()
            self.descriptionTextView.setNeedsLayout()
            self.descriptionTextView.layoutIfNeeded()
        }
    }
}
