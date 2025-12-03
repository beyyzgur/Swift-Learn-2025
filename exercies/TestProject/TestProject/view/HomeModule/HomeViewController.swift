//
//  HomeViewController.swift
//  TestProject
//
//  Created by beyyzgur on 1.12.2025.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func DetailButtonClicked(_ sender: UIButton) {
        StoryboardNavigableManager.shared.push(navigationController: navigationController,
                                               storyboardIdentifier: .detail,
                                               animated: true)
    }
    
    @IBAction func ProfileButtonClicked(_ sender: UIButton) {
        StoryboardNavigableManager.shared.push(navigationController: navigationController,
                                               storyboardIdentifier: .profile,
                                               animated: true)
    }
}
