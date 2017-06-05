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
