#!/usr/bin/env swift

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

// Can use self to access an instance variable
// over a parameter when there is ambiguity
struct TooManyCooks {
    var cook = "Anatole"
    func isLexicallyPrior(cook: String) -> Bool {
        return self.cook > cook
    }
}

let tooManyCooks = TooManyCooks()
print(tooManyCooks.isLexicallyPrior(cook: "Abelard"))
