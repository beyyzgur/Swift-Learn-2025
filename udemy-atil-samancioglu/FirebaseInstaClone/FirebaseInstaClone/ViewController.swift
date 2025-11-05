//
//  ViewController.swift
//  FirebaseInstaClone
//
//  Created by beyyzgur on 25.07.2025.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func signInClicked(_ sender: UIButton) {
        guard emailTextField.text != "", passwordTextField.text != "" else {
            makeAlert(title: "Error", message: "Please enter email and password")
            return
        }
        
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            guard error == nil else {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "error")
                return }
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
        }
    }
    
    /// beyza@emre.com => ayaz123

    @IBAction func signUpClicked(_ sender: UIButton) {
        guard emailTextField.text != "", passwordTextField.text != "" else {
            makeAlert(title: "Error", message: "Please enter email and password")
            return
        }
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authResult, error in
            guard error == nil else {
                self.makeAlert(title: "Error", message: error!.localizedDescription)
                return }
            self.performSegue(withIdentifier: "toFeedVC", sender: nil)
            
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton =  UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}
