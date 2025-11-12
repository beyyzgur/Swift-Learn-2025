import Foundation

// nested type


struct Game {
    
    enum Status {
        case playing
        case paused
        case finished
    }
    
    struct Card {
        let letter: String
    }

    var status: Status = .paused// bu status Game scope unda tanımlı bir property
}

//Game.Status.finished

//let status = Game.Status.finished
//print(status)

let status: Game.Status = .finished // bu ise playgroundumun global scope unda tanımlı, bu yüzden struct içerisindeki status ile çakışmıyor.
//print(status)

// member - wise
var game = Game()

if game.status == .playing {
    print("")
}

switch game.status {
case .playing:
    print("beyza wants to became the best swift developer")
case .finished:
    print("2")
case .paused:
    print("3")
default:
    print("")
}

let card = Game.Card(letter: "a")
print(card)

// typealias

typealias Status = Game.Status
Status.paused

typealias 🃏 = Game.Card
🃏(letter: "J")
Game.Card(letter: "J")
