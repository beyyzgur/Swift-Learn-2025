import UIKit

struct Person {
    var fullName: String {
        didSet {
            nameChanged()
        }
        willSet {
            print("fullName is changed from \(fullName) to \(newValue)")
        }
    }
    var age: Int {
        didSet {
            print("new age = \(age)")
            ageChanged()
        }
    }
    private var birthYear: Int = 0
    
    init(fullName: String, age: Int) {
        self.fullName = fullName
        self.age = age
    }
    
    // MARK: - Private Methods
    
    private func nameChanged() {
        print("name has changed")
    }
    
    private mutating func ageChanged() {
        birthYear = 2025 - age
        print(birthYear)
    }
}

var person = Person(fullName: "beyza", age: -1)
person.age = 0
person.fullName = "beyza gur"


// Computed property ile değer değiştirilebilir, Property observers ise değeri değiştiremez, sadece değer değişikliklerini izlemek için kullanılır.
