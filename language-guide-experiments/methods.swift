#!/usr/bin/env swift

// this variable is just here to demonstrate scoping
var count = 190
// instance methods
class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}

let counter = Counter()
counter.increment(by: 180)
print(counter.count)

// You can use ''self'' to access an instance variable
// over a parameter when there is ambiguity
struct TooManyCooks {
    var cook = "Anatole"
    func isLexicallyPrior(cook: String) -> Bool {
        return self.cook > cook
    }
}

let tooManyCooks = TooManyCooks()
print(tooManyCooks.isLexicallyPrior(cook: "Abelard"))

// by default the properties of a value type cannot
// be modified

/* causes error:
error: left side of mutating operator isn't mutable: 'self' is immutable
./methods.swift:39:5: note: mark method 'mutating' to make 'self' mutable

struct xHolder {
    var x = 0
    func incrementX() {
        x += 1
    }
}
*/

struct X {
    var x = 0
    mutating func incrementX() {
        x += 1
    }
}

var x = X()
print(x.x)
x.incrementX()
print(x.x)

class BankAccount {
    static var largestBalanceAtBank = 0
    class func bergeronize() {
        largestBalanceAtBank = 0
    }
    var accountBalance = 0 {
        didSet {
            if accountBalance > BankAccount.largestBalanceAtBank {
                BankAccount.largestBalanceAtBank = accountBalance
            }
        }
    }
}

var peasant = BankAccount()
peasant.accountBalance = 10
print(BankAccount.largestBalanceAtBank)
var prince = BankAccount()
prince.accountBalance = 10_000_000
print(BankAccount.largestBalanceAtBank)
BankAccount.bergeronize()
print(BankAccount.largestBalanceAtBank)

