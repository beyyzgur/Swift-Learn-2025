//
//  ViewController.swift
//  SegueApp
//
//  Created by beyyzgur on 14.05.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var firstViewControllerLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    var userName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad func called")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear func called")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("viewWillAppear func called")
        nameTextField.text = ""
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("viewWillDisappear func called")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("viewDidDisappear func called")
    }
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        userName = nameTextField.text!
        performSegue(withIdentifier: "toSecondViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSecondViewController" {
            let destinationVC = segue.destination as! SecondViewController
            destinationVC.myName = userName
        }
    }
}
