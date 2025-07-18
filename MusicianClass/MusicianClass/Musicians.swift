//
//  Musicians.swift
//  MusicianClass
//
//  Created by beyyzgur on 18.07.2025.
//

import Foundation

enum MusicianType {
    case LeadGuitarist
    case Bassist
    case Drummer
    case Violenist
    case Vocalist
}

class Musicians {
    var name: String
    var age: Int
    var instrument: String
    var musicianType: MusicianType
    
    init(name: String, age: Int, instrument: String, type: MusicianType){
        self.name = name
        self.age = age
        self.instrument = instrument
        self.musicianType = type
    }
    
    func sing() {
        print("Shake it off! 💃🏼")
    }
}
