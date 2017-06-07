#!/usr/bin/env swift

struct BankAccount {
    var balance: Int
    init() {
        balance = 100
    }
}

var account = BankAccount()
print("The default account balance is $\(account.balance)")

struct InternationalAccount {
    var usDollarsBalance: Double
    init(fromDollars usDollars: Double) {
        usDollarsBalance = usDollars
    }
    init(fromBaht thaiBaht: Double) {
        usDollarsBalance = thaiBaht / 34.0
    }
    init(_ usDollars: Double) {
        usDollarsBalance = usDollars
    }
}

let aLotOfBaht = InternationalAccount(fromBaht: 68_000_100)
let notALotOfBaht = InternationalAccount(fromBaht: 100)

print(aLotOfBaht.usDollarsBalance)
print(notALotOfBaht.usDollarsBalance)

class UndraftedFreeAgent {
    let fullName: String
    // this property is optional because the UDFA
    // may never get signed and may earn nothing.
    // In fact, this is usually what happens.
    var salary: Int?
    init(fullName: String) {
        self.fullName = fullName
    }
    func displayName() {
        print(fullName)
    }
}

let udfa = UndraftedFreeAgent(fullName: "Robert 'Fat Rob' Kelley")
udfa.displayName()
// We signed him!
udfa.salary = 540_000

class NaturalNumbers {
    var one = 1
    var two = 2
    var three = 3
    var etCetera: String?
}
var naturalNumbers = NaturalNumbers()


