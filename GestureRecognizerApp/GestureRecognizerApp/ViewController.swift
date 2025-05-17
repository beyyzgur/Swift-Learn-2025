//
//  ViewController.swift
//  GestureRecognizerApp
//
//  Created by beyyzgur on 17.05.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tapLabel: UILabel!
    
    var isSebnem = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(changePic))
        imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func changePic() {
        
        print("ilk gtap")
        /*if imageView.image == UIImage(named: "sebnem") { // UIImage(named:) her çağrıldığında yeni bir UIImage nesnesi oluşturur. Yani bu kod
            imageView.image = UIImage(named: "yalin") // çoğu zaman false döner çünkü bellekteki referanslar farklıdır, içerik aynı olsa bile.
            nameLabel.text = "Yalın"
        } else {
            imageView.image = UIImage(named: "sebnem")
            nameLabel.text = "Şebnem Ferah"
        }*/
        
        if isSebnem == true {
            imageView.image = UIImage(named: "yalin")
            nameLabel.text = "Yalın"
            isSebnem = false
        } else if isSebnem == false {
            imageView.image = UIImage(named: "sebnem")
            nameLabel.text = "Şebnem"
            isSebnem = true
        }
    }
}
