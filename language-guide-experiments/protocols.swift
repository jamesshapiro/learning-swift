#!/usr/bin/env swift
import Foundation

// Protocol properties:
// ====================

protocol ProtocolOne {
    var mustBeSettable: Int { get set }
    var notNecessarilySettable: Int { get }
    static var typeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Player: FullyNamed {
    var fullName: String
}

let wr = Player(fullName: "Josh Doctson")

class SportsTeam: FullyNamed {
    var city: String?
    var name: String
    init(name: String, city: String? = nil) {
        self.name = name
        self.city = city
    }
    var fullName: String {
        return (city != nil ? "The \(city!) " : "The ") + name
    }
}
var washington = SportsTeam(name: "Redskins", city: "Washington")
print(washington.fullName)
// The Washington Redskins

// Protocol methods that can mutate value types:
// =============================================

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var tvSwitch = OnOffSwitch.off
tvSwitch.toggle()
print(tvSwitch)
// prints: on

// Protocols and inheritance example:
// ==================================

protocol SomeProtocol {
    init()
}
 
class SomeSuperClass {
    init() { }
}
 
class SomeSubClass: SomeSuperClass, SomeProtocol {
    required override init() { }
}

// Protocol methods:
// =================

protocol RandomNumberGenerator {
    func random() -> Double
}

class KeepinItGenerator: RandomNumberGenerator {
    func random() -> Double {
        return Double(arc4random_uniform(100))/100.0
    }
}

let generator = KeepinItGenerator()
print("Here is a random number: \(generator.random())")
print("Here is another: \(generator.random())")

// Protocols as types:
// ===================

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

let die = Dice(sides: 6, generator: KeepinItGenerator())
for _ in 0..<30 {
    print(die.roll(), terminator: " ")
}
print("")

// Delegation design pattern:
// ==========================

protocol DiceGame {
    var dice: Dice { get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class FirstPersonToRollASixWins: DiceGame {
    let dice = Dice(sides: 6, generator: KeepinItGenerator())
    var itIsCurrentlyPlayerOnesTurn = true
    var delegate: DiceGameDelegate?
    func play() {
        delegate?.gameDidStart(self)
        while true {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            if diceRoll == 6 && itIsCurrentlyPlayerOnesTurn {
                print("Player 1 won!")
                break
            } else if diceRoll == 6 {
                print("Player 2 won!")
                break
            }
            itIsCurrentlyPlayerOnesTurn = !itIsCurrentlyPlayerOnesTurn
        }
        delegate?.gameDidEnd(self)
    }
}

class DiceGameTracker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(_ game: DiceGame) {
        numberOfTurns = 0
        if game is FirstPersonToRollASixWins {
            print("Started a new game of First Person To Roll A Six Wins")
        }
        print("The game is using a \(game.dice.sides)-sided dice")
    }
    func game(_ game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Rolled a \(diceRoll)")
    }
    func gameDidEnd(_ game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTracker()
let game = FirstPersonToRollASixWins()
game.delegate = tracker
game.play()

// Protocol Conformance via Extensions:
// ====================================

protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided die"
    }
}

let d100 = Dice(sides: 100, generator: KeepinItGenerator())
print(d100.textualDescription)
// Prints "A 100-sided die"

extension FirstPersonToRollASixWins: TextRepresentable {
    var textualDescription: String {
        return "A game of First Person To Roll A Six Wins"
    }
}
print(game.textualDescription)


// Collections of Protocol Types:
// ==============================

struct Binturong {
    var name: String
    var textualDescription: String {
        return "A binturong named \(name)"
    }
}
extension Binturong: TextRepresentable {}
let benjaminTheBinturong = Binturong(name: "Benjamin the Binturong")
let somethingTextRepresentable: TextRepresentable = benjaminTheBinturong
print(somethingTextRepresentable.textualDescription)
// Prints "A binturong named Benjamin the Binturong"

let things: [TextRepresentable] = [game, d100, benjaminTheBinturong]
for thing in things {
    print(thing.textualDescription)
}

// Protocol inheritance:
// =====================

protocol InheritingProtocol: ProtocolOne, FullyNamed {

}

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualDescription: String { get }
}

extension Binturong: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = String(repeating: "*", count: 18 + 4 + self.name.characters.count)
        output.append("\n* \(self.textualDescription) *\n")
        output.append(String(repeating: "*", count: 18 + 4 + self.name.characters.count))
        return output
    }
}

print(benjaminTheBinturong.prettyTextualDescription)
//Prints:
// ********************************************
// * A binturong named Benjamin The Binturong *
// ********************************************

let ty = Binturong(name: "Ty")
print(ty.prettyTextualDescription)
//Prints:
// ************************
// * A binturong named Ty *
// ************************

// Class-Only Protocols:
// =====================
protocol someClassOnlyProtocol: AnyObject, TextRepresentable {

}
// (only objects can conform to the AnyObject protocol)

// Protocol Composition:
// =====================
protocol Named {
    var name: String { get }
}

protocol Rostered {
    var jerseyNumber: Int { get }
}

struct ProAthlete: Named, Rostered {
    var name: String
    var jerseyNumber: Int
}

func wishHappyBirthday(to celebrant: Named & Rostered) {
    print("Happy birthday, \(celebrant.name), your jersey number is \(celebrant.jerseyNumber)!")
}

let birthdayPerson = ProAthlete(name: "Ryan Kerrigan", jerseyNumber: 91)
wishHappyBirthday(to: birthdayPerson)
// Prints: Happy birthday, Ryan Kerrigan, your jersey number is 91!

// Inheriting from a class and protocol(s):
// ========================================

class Location {
    var city: String
    var state: String
    init(city: String, state: String) {
        self.city = city
        self.state = state
    }
}

class NonNomad: Location, Named {
    var name: String
    init(name: String, city: String, state: String) {
        self.name = name
        super.init(city: city, state: state)
    }
}

/* Note: The tutorial says to write something like the following:
func listLocationOf(_ person: Location & Named) {
    print("Hello \(person.name)!")
}

let vernon = NonNomad(name: "Vernon Davis", city: "Washington", state: "DC")
listLocationOf(vernon)

HOWEVER, I keep seeing:
  error: non-protocol type 'Location' cannot be used within a protocol composition
I'm wondering if this was something introduced in Swift 4, or if I'm missing something...
*/

// Checking for Protocol Conformance:
// ==================================

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = Double.pi
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
}

class Country: HasArea {
    var area: Double
    init(area: Double) { self.area = area }
}

class FootballPlayer {
    var yards: Int
    init(yards: Int) { self.yards = yards }
}

let objects: [AnyObject] = [
  Circle(radius: 10.0),
  Country(area: 3_797_000),
  FootballPlayer(yards: 15_000)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}

// Area is 314.159265358979
// Area is 3797000.0
// Something that doesn't have an area

// Optional Protocol Requirements:
// ===============================

// For the purpose of compatability with Objective-C

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class FixedIncrement: NSObject, CounterDataSource {
    let fixedIncrement: Int
    init(amount: Int) {
        fixedIncrement = amount
    }
}

var counter = Counter()
counter.dataSource = FixedIncrement(amount: 7)
for _ in 1...7 {
    counter.increment()
    print(counter.count)
}

// 7
// 14
// 21
// 28
// 35
// 42
// 49

class ZeroMagnet: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            print("The time has come!")
            return 0
        } else if count < 0 {
            return 1
        } else {
            return -1
        }
    }
}

counter.count = -4
counter.dataSource = ZeroMagnet()
for _ in 1...6 {
    counter.increment()
    print(counter.count)
}

// -3
// -2
// -1
// 0
// The time has come!
// 0
// The time has come!
// 0

// Protocol Extensions:
// ====================

extension RandomNumberGenerator {
    func randomBool() -> Bool {
        let randomValue = random()
        return randomValue >= 0.25 && randomValue < 0.75
    }
}

let anotherGenerator = KeepinItGenerator()
print("Here's a random number: \(anotherGenerator.random())")
// Prints "Here's a random number: 0.04"
print("And here's a random Boolean: \(anotherGenerator.randomBool())")
// Prints "And here's a random Boolean: true"

// Providing Default Implementations:
// If the conforming type provides its own implementation,
// it will override this default implementation
extension PrettyTextRepresentable  {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

let max = Binturong(name: "Max")
print(max.prettyTextualDescription)
// Prints: 
// *************************
// * A binturong named Max *
// *************************
// despite the default

// Addings constraints to Protocol Extensions

extension Collection where Iterator.Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

let kirkTheBinturong = Binturong(name: "Kirk")
let coltTheBinturong = Binturong(name: "Colt")
let nateTheBinturong = Binturong(name: "Nate")
let binturongs = [kirkTheBinturong, coltTheBinturong, nateTheBinturong]

print(binturongs.textualDescription)
// [A binturong named Kirk, A binturong named Colt, A binturong named Nate]
