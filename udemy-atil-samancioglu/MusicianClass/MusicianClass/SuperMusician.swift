//
//  SuperMusician.swift
//  MusicianClass
//
//  Created by beyyzgur on 18.07.2025.
//

import Foundation

class SuperMusician : Musicians {
    func sing2() {
        print("Yeniden, yandı tüm ışıklar yeniden 🌦️")
    }
    
    override func sing() {
        super.sing()
        sing2()
        print("Benimki geliyor 🤭")
    }
}
