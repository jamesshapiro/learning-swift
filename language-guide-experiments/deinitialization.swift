#!/usr/bin/env swift

class NovigradBank {
    static var crownsInBank = 10_000
    static func distribute(crowns numberOfCrownsRequested: Int) -> Int {
        let numberOfCrownsToVend = min(numberOfCrownsRequested, crownsInBank)
        crownsInBank -= numberOfCrownsToVend
        return numberOfCrownsToVend
    }
    static func receive(crowns: Int) {
        crownsInBank += crowns
    }
}

class Geralt {
    var crownsInSaddle: Int
    init(crowns: Int) {
        crownsInSaddle = NovigradBank.distribute(crowns: crowns)
    }
    func win(crowns: Int) {
        crownsInSaddle += NovigradBank.distribute(crowns: crowns)
    }
    deinit {
        NovigradBank.receive(crowns: crownsInSaddle)
    }
}

var geralt: Geralt? = Geralt(crowns: 100)
print("Geralt has joined the game with \(geralt!.crownsInSaddle) crowns")
print("There are now \(NovigradBank.crownsInBank) crowns left in the bank")
geralt!.win(crowns: 1_000)
print("Geralt won 1000 crowns and nwo has \(geralt!.crownsInSaddle) crowns")
print("The bank now only has \(NovigradBank.crownsInBank) crowns left")
geralt = nil
print("Geralt died")
print("The bank now has \(NovigradBank.crownsInBank) crowns")



