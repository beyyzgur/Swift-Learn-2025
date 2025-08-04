//
//  OptionsViewController.swift
//  FoursquareClone
//
//  Created by beyyzgur on 31.07.2025.
//

import UIKit

final class OptionsViewController: UIViewController, AlertPresentable {

    @IBOutlet private weak var placeNameTextField: UITextField!
    @IBOutlet private weak var placeTypeTextField: UITextField!
    @IBOutlet private weak var placeAtmosphereTextField: UITextField!
    @IBOutlet private weak var placeImageView: UIImageView!
    private var defaultImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDefaultPlaceImageView()
        setGestureRecognizers()
}
    
    @IBAction func nextButtonClicked(_ sender: UIButton) {
        if textFieldsInfoControl() {
            let placeModel = PlaceModel.sharedInstance
            placeModel.placeName = placeNameTextField.text!
            placeModel.placeType = placeTypeTextField.text!
            placeModel.placeAtmosphere = placeAtmosphereTextField.text!
            placeModel.placeImage = placeImageView.image!
            
            performSegue(withIdentifier: "toMapVC", sender: nil)
        }
    }
    
    func setDefaultPlaceImageView() {
        defaultImage = UIImage(named: "daireselButton")
        placeImageView.image = defaultImage
    }
    
    func setGestureRecognizers() {
        placeImageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        placeImageView.addGestureRecognizer(gestureRecognizer)
    }
    
    func textFieldsInfoControl() -> Bool {
        guard placeNameTextField.text != "" else {
            makeAlert(title: "Oups!", message: "Please enter the place name")
            return false
        }
        guard placeTypeTextField.text != "" else {
            makeAlert(title: "Oups!", message: "Please enter the place type")
            return false
        }
        guard placeAtmosphereTextField.text != "" else {
            makeAlert(title: "Uups!", message: "Please enter the atmosphere")
            return false
        }
        guard placeImageView.image != nil && placeImageView.image != defaultImage else {
            makeAlert(title: "Oh no!", message: "Please select an image for your place")
            return false
        }
        return true
    }
        
}

extension OptionsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func chooseImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        placeImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
}
