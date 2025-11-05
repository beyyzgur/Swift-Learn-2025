//
//  ViewController.swift
//  FoursquareClone
//
//  Created by beyyzgur on 31.07.2025.
//

import UIKit
import Parse

typealias ViewControllerItems = AlertPresentable

final class SignViewController: UIViewController, ViewControllerItems {
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction private func signInButtonClicked(_ sender: UIButton) {
        textFieldsInfoControl()
        
        PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { (user, error) in
            guard error == nil else {
                self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error")
                return
            }
            self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
            self.makeAlert(title: "Welcome \(user?.username ?? "user")!", message: "Happy to see you 🌺")
            print("Welcome \(user?.username ?? "user")")
        }
    }
    
    @IBAction private func signUpButtonClicked(_ sender: UIButton) {
        textFieldsInfoControl()
        
        let user = PFUser()
        user.username = userNameTextField.text
        user.password = passwordTextField.text
        
        user.signUpInBackground { (success, error) in
            guard error == nil else {
                self.makeAlert(title: "Error! Could not sign up", message: error?.localizedDescription ?? "Please try again.")
                return
            }
            self.performSegue(withIdentifier: "toPlacesVC", sender: nil)
            print("basardin kız!!🌸")
        }
    }
    
    func textFieldsInfoControl() {
        guard userNameTextField.text != "" else {
            makeAlert(title: "Oups!", message: "Please enter your username")
            return
        }
        guard passwordTextField.text != "" else {
            makeAlert(title: "Oups!", message: "Please enter your password")
            return
        }
    }
}
