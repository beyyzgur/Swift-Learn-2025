//
//  AlertPresentable.swift
//  FoursquareClone
//
//  Created by beyyzgur on 31.07.2025.
//

import UIKit

protocol AlertPresentable {
    func makeAlert(title: String, message: String)
}

extension AlertPresentable where Self: UIViewController {
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
}
