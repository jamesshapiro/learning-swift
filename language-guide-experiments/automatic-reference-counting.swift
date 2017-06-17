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

class Contract {
    let salary: Int
    init(salary: Int) { self.salary = salary }
    var player: Player3?
    deinit { print("contract worth \(salary) is being deinitialized") }
}

class Player3 {
    let name: String
    init(name: String) { self.name = name }
    weak var contract: Contract?
    deinit { print("Player \(name) is being deinitialized") }
}

var mattJones: Player3?
var contract: Contract?

mattJones = Player3(name: "Matt Jones")
contract = Contract(salary: 629_000)

mattJones!.contract = contract
contract!.player = mattJones

// Prints "contract worth 629000 is being deinitialized"
contract = nil

// Prints "Player Matt Jones is being deinitialized"
mattJones = nil

class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) { self.name = name }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card #\(number) is being deinitialized") }
}

var bashaud: Customer?
bashaud = Customer(name: "Bashaud Breeland")
bashaud!.card = CreditCard(number: 2626_2266_2222_6666, customer: bashaud!)

bashaud = nil

//Case 3: Neither property can be nil
class Division {
    let name: String
    var bestTeam: Team!
    init(name: String, bestTeamName: String) {
        self.name = name
        self.bestTeam = Team(name: bestTeamName, division: self)
    }
    deinit {
        print("deinitializing: \(name)")
    }
}

class Team {
    let name: String
    unowned let division: Division
    init(name: String, division: Division) {
        self.name = name
        self.division = division
    }
    deinit {
        print("deinitializing: \(name)")
    }
}

var division = Division(name: "NFCWest", bestTeamName: "Seahawks")
print("\(division.name)'s best team is called The \(division.bestTeam.name)")
division.bestTeam = Team(name: "Cardinals", division: division)

// ============================================================

// Strong Reference Cycles for Closures:
class HTMLElement {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
// Prints "<h1>some default text</h1>"
print(heading.asHTML())

var httr: HTMLElement? = HTMLElement(name: "p", text: "Hail to the Redskins!")
print(httr!.asHTML())
// httr is not deinitialized:
httr = nil

class HTMLElement2 {
    let name: String
    let text: String?

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

var httr2: HTMLElement2? = HTMLElement2(name: "p", text: "Hail to the Redskins!")
// Prints "<p>Hail to the Redskins!</p>
print(httr2!.asHTML())
// Prints "p is being deinitialized"
httr2 = nil
    
