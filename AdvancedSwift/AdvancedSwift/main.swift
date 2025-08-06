//
//  main.swift
//  AdvancedSwift
//
//  Created by beyyzgur on 4.08.2025.
//

import Foundation

let classBeyza = MusicianClass(name: "Beyza", age: 21, instrument: "violin")

var structEmre = MusicianStruct(name: "Emre", age: 23, instrument: "piano")

//print("\(structEmre.name) <3 \(classBeyza.name)")

classBeyza.age = 80
//print(classBeyza.age)

structEmre.age = 82
//print(structEmre.age)

// MARK: - Reference vs. Value

let copyOfClassBeyza = classBeyza

let copyOfStructEmre = structEmre

//print(copyOfClassBeyza)
//print(copyOfStructEmre)

// reference types => class
//copy => same object new reference -> 1 object 2 reference

// value types => struct
// copy -> new object -> 2 objects 

// MARK: - Function vs Mutating Function

//print(classBeyza.age)
//classBeyza.happyBirthday()
//print(classBeyza.age)
//
//print(structEmre.age)
//structEmre.happyBirthday()
//print(structEmre.age)

// MARK: - Tuple

let tuple = (1,3)
//print(tuple.0)
//print(tuple.1)

var tuple2 = (3, "Beyza", true)
tuple2.1 = "Emre"
//print(tuple2)

let tuple3 = (10, [10, 20, 30])
print(tuple3.1[1])

let predefinedTuple : (String, String, String)

predefinedTuple.0 = "Beyzoş"
predefinedTuple.1 = "&"
predefinedTuple.2 = "Emroş"

print("\(predefinedTuple.0) \(predefinedTuple.1) \(predefinedTuple.2)")

let tupleM = (name: "Beyza", isMarried: false)
print(tupleM.isMarried)

// MARK: - Guard let vs if let

let number = "Apple"

func convertToIntegerGuard(string: String) -> Int {
    guard let myNumber = Int(string) else {
        return 0
    }
    return Int(myNumber)
}

func convertToIntegerIf(string: String) -> Int {
    if let myNumber = Int(string) {
        return Int(myNumber)
    } else {
        return 0
    }
}

print(convertToIntegerIf(string: number))
print(convertToIntegerGuard(string: number))


// MARK: - Switch

let myNum = 11

switch myNum {
case 1...10:
    print("1...10")
case 11...20:
    print("11...20")
case 21...30:
    print("21...30")
default:
    print("its not in any range")
}

// MARK: - Breakpoint

var x = 5

print(x)

x += 1

print(x)
