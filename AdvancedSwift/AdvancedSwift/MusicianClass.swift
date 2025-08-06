//
//  MusicianClass.swift
//  AdvancedSwift
//
//  Created by beyyzgur on 4.08.2025.
//

import Foundation

class MusicianClass {
    var name: String
    var age: Int
    var instrument: String
    
    init(name: String, age: Int, instrument: String) {
        self.name = name
        self.age = age
        self.instrument = instrument
    }
    
    func happyBirthday() {
        self.age += 1
    }
}
