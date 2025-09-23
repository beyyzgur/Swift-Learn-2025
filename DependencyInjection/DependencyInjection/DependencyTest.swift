//
//  DependencyTest.swift
//  DependencyInjection
//
//  Created by beyyzgur on 9.09.2025.
//

import Foundation
struct Instrument {
    var name : String
    var brand : String
}

struct Band {
    var name : String
}

struct Musician {
    var instrument : Instrument
    var band : Band
    var name : String
    var age : Int
}

let violin = Instrument(name: "keman", brand: "Handmade")
let band = Band(name: "Fairies")

let beyzos = Musician(instrument: violin, band: band, name: "beyzos", age: 21)
// Burda bağımlı olması durumu dependency injection diyebilir miyiz?
