//
//  ViewController.swift
//  FaceRecognitionApp
//
//  Created by beyyzgur on 25.07.2025.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func signInButtonClicked(_ sender: UIButton) {
        let authContext = LAContext()
        
        var error: NSError?
        if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Is it you?") { (success, error) in
                if success == true {
                    // succesfull auth
                    DispatchQueue.main.async {
                        self.performSegue(withIdentifier: "toSecondVC", sender: nil)
                    }
                } else {
                    
                    DispatchQueue.main.async {
                        self.label.text = "error"
                    }
                }
            }
        }
    }
}

