//
//  DetailsViewController.swift
//  ArtBookProject
//
//  Created by beyyzgur on 22.07.2025.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingID: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenPainting != "" {
            
            saveButton.isHidden = true
            
            //CoreData dan data cekeceğim
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = chosenPaintingID?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString ?? UUID().uuidString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            nameTextField.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String {
                            artistTextField.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int32 {
                            yearTextField.text = String(year)
                        }
                        if let image = result.value(forKey: "image") as? Data {
                            imageView.image = UIImage(data: image)
                        }
                    }
                }
            } catch {
                print("error var canim")
            }
        } else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
        }
        
        // MARK: - Recognizers
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        imageView.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        imageView.addGestureRecognizer(imageTapRecognizer)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func selectImage(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.editedImage] as? UIImage // Original Image yapabilirsin as general
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func saveButtonClicked(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate // App Delegate'i değişken olarak tanımladık
        let context = appDelegate.persistentContainer.viewContext
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        //Attributes
        
        newPainting.setValue(nameTextField.text, forKey: "name")
        newPainting.setValue(artistTextField.text, forKey: "artist")
        if let year = Int(yearTextField.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        newPainting.setValue(UUID(), forKey: "id")
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("Data saved successfully")
        }
        catch {
            print("Error saving data: \(error)")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
