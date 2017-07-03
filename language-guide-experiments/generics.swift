#!/usr/bin/env swift

// Generics:
// =========

func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    (a, b) = (b, a)
}
var touchdown = 3
var fieldGoal = 6
swapTwoInts(&touchdown, &fieldGoal)
print("TD: \(touchdown), FG: \(fieldGoal)")

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    (a, b) = (b, a)
}

var extraPoint = 2
var twoPointConversion = 1
swap(&extraPoint, &twoPointConversion)
print("extraPoint: \(extraPoint), twoPointConversion: \(twoPointConversion)")

var safety = "Pick Six"
var pickSix = "Safety"
swap(&safety, &pickSix)
print("safety: \(safety), pickSix: \(pickSix)")

struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}

struct Pancake {
    var radius = 1
    init(radius: Int) { self.radius = radius }
}

var stackOfPancakes = Stack<Pancake>()
stackOfPancakes.push(Pancake(radius: 3))
stackOfPancakes.push(Pancake(radius: 2))
stackOfPancakes.push(Pancake(radius: 1))

var topPancake = stackOfPancakes.pop()
print(topPancake)
// Prints: Pancake(radius: 1)

topPancake = stackOfPancakes.pop()
print(topPancake)
// Prints: Pancake(radius: 2)

// Extending generics:
// ===================

extension Stack {
    func peek() -> Element? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

print(stackOfPancakes.peek()!)

// Type constraints:
// =================

func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let oneHundredIndex = findIndex(of: 1_000_000, in: [1, 10, 100, 1000])
let stringIndex = findIndex(of: "red", in: ["blue", "green", "red"])
print(stringIndex!)

// Associated Types:
// =================

protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

/*struct intStack: Container {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    typealias Item = Int
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
// OR: omit the "typealias" line because Swift
// is smart enough to infer the type of Item
// by looking at the argument to append
*/

struct intStack: Container {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Int {
        return items[i]
    }
}
