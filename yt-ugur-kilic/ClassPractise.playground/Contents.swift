import Foundation
// class

// struct - class

//struct Game {
//   private(set) var status: String = ""
//   private(set) var currentPlayer: String = ""
//   private(set) var index: Int = -1
//    
//    mutating func moveNextPlayer() {
//        if currentPlayer == "" {
//            currentPlayer = "beyza"
//        } else {
//            currentPlayer = "emre"
//        }
//    }
//}
//
// immutability
//
// var game = Game()
//
// bir sürü game instance ı olacak struct oldugu icin
// 
//var game2 = game
//game2.moveNextPlayer() // copy on write
//
//game.currentPlayer
//game2.currentPlayer
//
//game.index // game.index 'e dısarıdan erisebilirim fakat değiştiremem cause of private(set)
//game.status


class Game {
   private(set) var status: String = ""
   private(set) var currentPlayer: String = ""
   private(set) var index: Int = -1
    
    func moveNextPlayer() {
        if currentPlayer == "" {
            currentPlayer = "beyza"
        } else {
            currentPlayer = "emre"
        }
    }
}

// 1 instance -- initializer'ı kaç kere çağırdıysam o kadar instance ım var.

let game = Game()

let game2 = game
game2.moveNextPlayer()

game.currentPlayer
game2.currentPlayer

// structta memberwise initializer default gelir, classta bunu kendimiz olusturmamız gerek.

class User {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let user = User(name: "beyza")

// struct - class ?

// 1) immutability
// 2) memory (class => referans type, struct, enum, double...  => value type)
// referans type => heap, value type => stack
// 3) deinitialization

// class
// cok değişmeyen ve güvenli olmasını istediğimiz, istemediğimiz dıs etkenlere karsı koruma
// storage, network, cok fazla fonksiyonalite ve içinde değişen data
// daha komplike yapılar

// struct
// data tipleri, fonksiyonalitesi az olan, uygulamaya ve koda etkisi az olan
// user, koordinat, customer datası, network modelleri
// daha basit yapılar

// identity operator

let game1 = Game()
let game3 = Game()
let game4 = game1

// game1 ---->       [GAME]          <----- game4

// game3 ---->       [GAME]

if (game1 === game4) {
    print("esit")
} else {
    print("değil")
}

if (game1 !== game4) {
    print("esit")
} else {
    print("değil")
}
