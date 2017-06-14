#!/usr/bin/env swift

class Player {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Player?
var reference2: Player?
var reference3: Player?

// Prints: Morgan Moses is being initialized
reference1 = Player(name: "Morgan Moses")
reference2 = reference1
reference3 = reference1

reference1 = nil
reference2 = nil
// Prints: Morgan Moses is being deinitialized
reference3 = nil
   
class Player2 {
    let name: String
    var jerseyNumber: JerseyNumber?
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialized")
    }
}

class JerseyNumber {
    let number: Int
    init(number: Int) { self.number = number }
    var player: Player2?
    deinit { print("Jersey Number \(number) is being deinitialized") }
}

var crowder: Player2?
var crowderJersey: JerseyNumber?

crowder = Player2(name: "Jamison Crowder")
crowderJersey = JerseyNumber(number: 80)

crowder!.jerseyNumber = crowderJersey
crowderJersey!.player = crowder

crowder = nil
crowderJersey = nil
// Strong reference cycle, so neither instance is deinitialized (!)
