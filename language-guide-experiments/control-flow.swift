#!/usr/bin/env swift

let insideLinebackers = ["Will", "Mason", "Zach", "Martrell"]

for linebacker in insideLinebackers {
    print("Hello, \(linebacker)")
}

let numberOfLegs = ["elephant": 4, "octopus": 8, "gorilla": 2]
for (animalName, legCount) in numberOfLegs {
    print("The \(animalName) has \(legCount) legs")
}
/* Note: the keys are unordered, as expected. Prints:
The octopus has 8 legs
The elephant has 4 legs
The gorilla has 2 legs
*/

for index in 1...99 {
    let bottles = 100 - index
    print("\(bottles) bottles of beer on the wall, \(bottles) bottles of beer! Take one down, pass it around, \(bottles - 1) bottles of beer on the wall!")
}

for _ in 0..<5 {
    print("five")
}

for seven in stride(from: 0, through: 70, by: 7) {
    print(seven)
}
// includes 70

let character: Character = "a"
switch character {
case "a", "A":
    print("This message is brought to you by the letter A")
default:
    print("This message is not brought to you by the letter A")
}

let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("\(somePoint) is inside the box")
default:
    print("\(somePoint) is outside of the box")
}

let yetAnotherPoint = (1, -1.0)
switch yetAnotherPoint {
case let (x, y) where abs(y) <= 1 && abs(x) == 1
                        || abs(y) == 1 && abs(x) <= 1:
    print("(\(x), \(y)) is on the unit square")
case let (x, y) where abs(x) <= 1 && abs(y) <= 1:
    print("(\(x), \(y)) is inside the unit square")
case let (x, y):
    print("(\(x), \(y)) is outside the unit square")
}
