//
//  SecondViewController.swift
//  SegueApp
//
//  Created by beyyzgur on 14.05.2025.
//

import UIKit

class SecondViewController: UIViewController {
    @IBOutlet weak var secondViewControllerLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    var myName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = myName
    }
}
