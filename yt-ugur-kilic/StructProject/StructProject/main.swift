//
//  main.swift
//  StructProject
//
//  Created by beyyzgur on 5.11.2025.
//
// Swift ile iOS Programlama - intermediate

import Foundation

// Struct
struct Person {
    var fullname: String
    var age: Int
    var birthDate: Date?
    var country = "Turkey"
    
    init(fullname: String, age: Int) {
        self.fullname = fullname
        self.age = age
    }
    
    init(name: String, surname: String, age: Int = -1){ // üstteki initi yazmadan sadece bunu yazarsan person1 hata verir
        self.fullname = "\(name) \(surname)"  // String Concatenation
        self.age = age
    }
    
    func whereAreYou() -> String {
        return "i am in \(country)"
    }
    
    mutating func yearPassed() { // mutating varlığı seni rahatsız etmeli, çünkü buna ihtiyaç duymak optimize kodu azaltır, genellikle hızlı kod yazman gereken yerlerde kullan
        age += 1 // person nesnesi direkt kendisi immutable - çünkü structlar immutable olarak her şeyi korur - istediğim gibi her yerden değiştiremem
    }
}

var person = Person(fullname: "Beyza Gür", age: 21)

let person2 = person

// copy on write - struct oldugu için value type - bu yüzden bellekte yeni nesne olusuyor "fr" dendiğinde

person.country = "fr" // kopyayı su asamada yaratıyor cunku kopya seklinde olusturulan person2de artık bu asamada bir değişiklik oluyor.

print(person)
print(person2)
print(person.whereAreYou())
person.yearPassed()
print(person.age)
