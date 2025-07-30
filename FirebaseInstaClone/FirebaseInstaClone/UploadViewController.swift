//
//  UploadViewController.swift
//  FirebaseInstaClone
//
//  Created by beyyzgur on 26.07.2025.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore
import FirebaseAuth

class UploadViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
        
    @IBAction func uploadButtonClicked(_ sender: UIButton) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media") /// media klasörü olusturur ve child dedikçe yeni klasörler oluşturarak datayı bu klasör içerisine kaydeder.
        let uuidString = UUID().uuidString
        if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
            let comment = commentTextField.text ?? "no_comment"
            let cleanedComment = comment.replacingOccurrences(of: " ", with: "_").prefix(20)
            let imageReference = mediaFolder.child("\(cleanedComment)_\(uuidString).jpg") /// uuidString yaptık cunku görsel ismi her seferinde farklı olmalı, aksi takdirde üzerine yazıyordu
            imageReference.putData(data, metadata: nil) { ( metadata, error) in
                guard error == nil else {
                    self.makeAlert(title: "Error! The data could not be uploaded", message: error!.localizedDescription)
                    print(error?.localizedDescription)
                    return
                }
                self.makeAlert(title: "Success!", message: "The data has been uploaded successfully")
                
                imageReference.downloadURL { (url, error) in
                    guard error == nil else {
                        self.makeAlert(title: "Error! The URL could not be obtained", message: error!.localizedDescription)
                        return }
                    let imgURL = url?.absoluteString
                    print(imgURL)
                    ///DATABASE
                    let firestoreDatabase = Firestore.firestore()
                    var firestoreReference: DocumentReference? = nil
                    let firestorePost = ["imgURL": imgURL,
                                         "postedBy": Auth.auth().currentUser?.email,
                                         "comment": self.commentTextField.text,
                                         "date": FieldValue.serverTimestamp(),
                                         "like": 0] as [String: Any]
                    firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { (error) in
                        guard error == nil else {
                            self.makeAlert(title: "Error", message: error?.localizedDescription ?? "Error in Storage")
                            return
                        }
                        print("the data has been added to firestore database successfully")
                        
                        self.imageView.image = UIImage(named: "select-image.png")
                        self.commentTextField.text = ""
                        
                        //self.performSegue(withIdentifier: "toFeedVC", sender: nil) => bu olmaz, identifier belirlemedik, zortlarsın
                        self.tabBarController?.selectedIndex = 0  // tabbar oldugunda böyle yap daha sağlıklı
                    })
                }
            }
        }
    }
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
    
}
/// EXTENSIONNN YAZACAĞIZZZ
extension UploadViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @objc func chooseImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil) /// Bu UIKit fonksiyonu, bir view controller'ı (burada UIImagePickerController) ekranda modally (yani üzerine çıkarak) göstermek için kullanılır.
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as! UIImage
        self.dismiss(animated: true, completion: nil)
    }

    
}
