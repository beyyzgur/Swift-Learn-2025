import UIKit

// Structs have 2 kind of property, the first is a stored property, where you place a value in to the struct directly,
// The second is called a computed property, it recalculates the value of the property evert time it's accessed.

struct Employee {
    let name: String
    var vacationAllocated = 14
    var vacationTaken = 0
    
    var vacationRemaining: Int {
        get {
            vacationAllocated - vacationTaken
        }
        set {
            vacationAllocated = vacationTaken + newValue
        }
    }
}

var archer = Employee(name: "Sterling Archer", vacationAllocated: 14)
archer.vacationTaken += 4
archer.vacationRemaining = 5
print(archer.vacationAllocated)

//archer.vacationRemaining
//archer.vacationTaken += 4 // her seferinde 4 ekliyoruz, her seferinde 4 e eşitlemiyoruz, bu yüzden += kullandık.
//archer.vacationRemaining

