#!/usr/bin/env swift

class Ancestor {
    var bankBalance = 3_000_000
    var house = 550_000
    var description: String {
        return "house and balance"
    }
    func makeNoise() {

    }
}

let keeneyEverett = Ancestor()
print("Ancestor: \(keeneyEverett.description)")

class Heir: Ancestor {
    var ruleAgainstPerpetuitiesApplies = false
}

let bronson = Heir()
bronson.bankBalance = 2_900_000

print("Heir: \(bronson.description)")

class HeirOfAnHeir: Heir {
    var selfIndulgentHobby = "Poetry"
}

let thirdGen = HeirOfAnHeir()
// prints $3MM
print(thirdGen.bankBalance)

class NoisyHeir: Heir {
    override func makeNoise() {
        print("NOISE!")
    }
}

let noisyHeir = NoisyHeir()
noisyHeir.makeNoise()


