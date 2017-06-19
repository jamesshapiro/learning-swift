#!/usr/bin/env swift

enum VendingMachineError: Error {
    case invalidSelection
    case notEnoughBitcoin(bitcoinNeeded: Bitcoin)
    case outOfStock
}

struct Bitcoin {
    var amount: Double = 0
    init(amount: Double) {
        self.amount = amount
    }
}

struct Item {
    var price: Bitcoin
    var count: Int
}

class VendingMachine {
  var inventory = [
    "Candy Bar": Item(price: Bitcoin(amount: 0.000_05), count: 7),
    "Dr Pepper": Item(price: Bitcoin(amount: 0.000_06), count: 4),
    "Pretzels": Item(price: Bitcoin(amount: 0.000_03), count: 11)
  ]
  var bitcoinDeposited = Bitcoin(amount: 0)

  func vend(itemNamed name: String) throws {
      guard let item = inventory[name] else {
          throw VendingMachineError.invalidSelection
      }

      guard item.count > 0 else {
          throw VendingMachineError.outOfStock
      }

      guard item.price.amount <= bitcoinDeposited.amount else {
          throw VendingMachineError.notEnoughBitcoin(bitcoinNeeded: Bitcoin(amount: item.price.amount - bitcoinDeposited.amount))
      }

      bitcoinDeposited.amount -= item.price.amount

      var newItem = item
      newItem.count -= 1
      inventory[name] = newItem

      print("Dispensing \(name)")
  }
}

let favoriteSnacks = [
  "Joey Mbu": "Candy Bar",
  "Nate Sudfeld": "Dr Pepper",
  "Stacy McGee": "Pretzels",
  "Ziggy Hood": "Life Savers"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

let vendingMachine = VendingMachine()
/*
try buyFavoriteSnack(person: "Joey Mbu", vendingMachine: vendingMachine)

Output:
fatal error: Error raised at top level: main.VendingMachineError.notEnoughBitcoin(main.Bitcoin(amount: 5.0000000000000002e-05)): file /Library/Caches/com.apple.xbs/Sources/swiftlang/swiftlang-802.0.53/src/swift/stdlib/public/core/ErrorType.swift, line 188
Current stack trace:
0    libswiftCore.dylib                 0x000000010b54b130 swift_reportError + 129
...
*/

/* 
let purchasedSnack = try PurchasedSnack(name: "Andy Capp's Hot Fries", vendingMachine: vendingMachine)

Output:
fatal error: Error raised at top level: main.VendingMachineError.invalidSelection: file /Library/Caches/com.apple.xbs/Sources/swiftlang/swiftlang-802.0.53/src/swift/stdlib/public/core/ErrorType.swift, line 188
Current stack trace:
0    libswiftCore.dylib                 0x000000010d763130 swift_reportError + 129

*/

func testErrorConditions(vendingMachine: VendingMachine,
amount: Bitcoin, person: String) throws {
    vendingMachine.bitcoinDeposited = amount
    do {
        try buyFavoriteSnack(person: person, vendingMachine: vendingMachine)
    } catch VendingMachineError.invalidSelection {
        print("Invalid Selection.")
    } catch VendingMachineError.outOfStock {
        print("Out of Stock.")
    } catch VendingMachineError.notEnoughBitcoin(let coinsNeeded) {
        print("Insufficient funds. Please insert an additional \(coinsNeeded.amount) BTC.")
    }
}
// Prints: Invalid selection
try testErrorConditions(vendingMachine: vendingMachine,
                    amount: Bitcoin(amount: 0.000_01),
                    person: "Ziggy Hood")
// Prints: Insufficient funds. Please insert an additional 5e-05 BTC.
try testErrorConditions(vendingMachine: vendingMachine,
                    amount: Bitcoin(amount: 0.000_01),
                    person: "Nate Sudfeld")
/* Prints:
Dispensing Dr Pepper
Dispensing Dr Pepper
Dispensing Dr Pepper
Dispensing Dr Pepper
Out of Stock.
*/
for _ in 1...5 {
    try testErrorConditions(vendingMachine: vendingMachine,
                    amount: Bitcoin(amount: 0.000_06),
                    person: "Nate Sudfeld")
}
