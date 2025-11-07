import UIKit
// access controls
// access modifiers

struct Person {
    var fullName: String
    private(set) var age: Int
    
    init(fullName: String) {
        self.fullName = fullName
        self.age = 21
    }
    
    mutating func yearPassed() {
        self.age += 1
        logYearPass()
    }
    
    private func logYearPass() {
        print("year has passed")
    }
    
}
var person = Person(fullName: "bbbb")
person.yearPassed()
(2025 - person.age)


 // fileprivate - open - public

