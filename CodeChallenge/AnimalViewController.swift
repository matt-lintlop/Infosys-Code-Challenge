//
//  AnimalViewController.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/24/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

class AnimalViewController: UIViewController {

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var favoriteToyLabel: UILabel!
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

    func setupViewController(with catalogItem:AnimalCatalogItem) {
        self.loadViewIfNeeded()
        self.title = catalogItem.itemIdentifier
        self.ageLabel.text = catalogItem.age
        self.favoriteToyLabel.text = catalogItem.favoriteToy
        self.descriptionTextView.text = catalogItem.objectSummary.description
        self.colorLabel.text = catalogItem.objectSummary.color
        self.headerLabel.text = "\(catalogItem.objectSummary.name.capitalized) The \(catalogItem.itemIdentifier.capitalized)"
        if let image = catalogItem.image {
            self.imageView.image = image
        }
        self.descriptionTextView.setContentOffset(CGPoint.zero, animated: false)
   }
    
/*    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 */
}
