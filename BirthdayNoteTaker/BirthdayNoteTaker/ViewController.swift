//
//  ViewController.swift
//  BirthdayNoteTaker
//
//  Created by beyyzgur on 9.05.2025.
//

import UIKit

class ViewController: UIViewController { // commit atmayı UNUTMAAA!!!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if let newName = storedName, let newBirthday = storedBirthday as? String {
            nameLabel.text = "Name: \(newName)"
            birthdayLabel.text  = "Birthday: \(newBirthday)"
        }
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        UserDefaults.standard.set(birthdayTextField.text, forKey: "birthday")
//        UserDefaults.standard.synchronize()
        
        nameLabel.text = "Name: \(nameTextField.text!)"
        birthdayLabel.text  = "Birthday: \(birthdayTextField.text!)"
    }
    
    @IBAction func deleteButtonClicked(_ sender: UIButton) {
        let storedName = UserDefaults.standard.object(forKey: "name")
        let storedBirthday = UserDefaults.standard.object(forKey: "birthday")
        
        if (storedName as? String) != nil && (storedBirthday as? String) != nil {
            UserDefaults.standard.removeObject(forKey: "name")
            nameLabel.text = "Name: "
            UserDefaults.standard.removeObject(forKey: "birthday")
            birthdayLabel.text  = "Birthday: "
            print("silindi")
        }
    }
}
