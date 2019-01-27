//
//  PizzaDetailViewController.swift
//  Zume-Code-Challenge
//
//  This class is a view controller that shows the information
//  about a pizza.
//
//  Created by Matt Lintlop on 9/24/18.
//  Copyright © 2019 Matt Lintlop. All rights reserved.
//

import UIKit

class PizzaDetailViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var purchaseDateLabel: UILabel!
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

    func setupViewController(withPizza pizza:Pizza) {
//        self.loadViewIfNeeded()
//        self.title = pizzaSummary.pizzaIdentifier
//        self.purchaseDateLabel.text = pizzaSummary.purchaseDate
//        self.descriptionTextView.text = pizzaSummary.description
//        self.colorLabel.text = pizzaSummary.color
//        self.headerLabel.text = "\(pizza.pizzaSummary.name.capitalized) The \(pizza.pizzaIdentifier.capitalized)"
//        self.descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
//        self.descriptionTextView.setNeedsDisplay()
//        self.showStartOfText = true
//        if let image = pizza.image {
//            self.imageView.alpha = 0.0
//            UIView.animate(withDuration: 0.5, animations: {
//                    self.imageView.image = image
//                    self.imageView.alpha = 1.0
//          })
//        }
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
