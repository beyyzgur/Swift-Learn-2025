//
//  ViewController.swift
//  DarkModeApp
//
//  Created by beyyzgur on 25.07.2025.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var changeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // burası olmaz cunku burası sadece app calıstırıldıgında 1 kez calisir
        
       // overrideUserInterfaceStyle = .light => sadece bulundugu viewcontroller 'ın mode 'unu kalıcı olarak değiştirir
        // bütün app 'in modunu değiştirmek için => ?
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // burası da olmaz cunku renkler sayfa değiştirilip tekrat aynı sayfaya gelmeden gelmez
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // ✅ burası okey ama func deprecated olmuş
        let userInterfaceStyle = traitCollection.userInterfaceStyle
        if userInterfaceStyle == .dark {
            changeButton.tintColor = UIColor(.yellow)
        } else {
            changeButton.tintColor = UIColor(.purple)
        }
    }

}

