//
//  ViewController.swift
//  AlertProject
//
//  Created by beyyzgur on 16.05.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signUpButtonClicked(_ sender: Any) {
        if userNameTextField.text == "" {
            adjustSignUpButton(title: "Error!", message: "UserName is required")
        } else if passwordTextField.text == "" {
            adjustSignUpButton(title: "Error!", message: "Password is required")
        } else if passwordTextField.text != verifyPasswordTextField.text {
            adjustSignUpButton(title: "Error!", message: "Passwords do not match")
        } else {
            adjustSignUpButton(title: "Success", message: "You have successfully signed up")
        }
    }
    
    func adjustSignUpButton(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
