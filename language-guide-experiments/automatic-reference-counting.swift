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
