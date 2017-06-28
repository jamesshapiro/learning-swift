#!/usr/bin/env swift
import Foundation

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

protocol RandomNumberGenerator {
    func random() -> Int
}

class KeepinItGenerator: RandomNumberGenerator {
    func random() -> Int {
        return Int(arc4random_uniform(100))
    }
}

let generator = KeepinItGenerator()
print("Here is a random number between 0-100: \(generator.random())")
print("Here is another: \(generator.random())")

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

protocol SomeProtocol {
    init()
}
 
class SomeSuperClass {
    init() { }
}
 
class SomeSubClass: SomeSuperClass, SomeProtocol {
    required override init() { }
}



