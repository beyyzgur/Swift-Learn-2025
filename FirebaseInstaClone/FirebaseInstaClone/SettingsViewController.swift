//
//  SettingsViewController.swift
//  FirebaseInstaClone
//
//  Created by beyyzgur on 26.07.2025.
//

import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButtonClicked(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toViewController", sender: nil)
        } catch {
            print("Error: Cannot sign out")
        }
    }

}
