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

