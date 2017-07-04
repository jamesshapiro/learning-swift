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

/*struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}*/

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

struct IntStack: Container {
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

func allItemsMatch<C1: Container, C2: Container>
(_ someContainer: C1, _ anotherContainer: C2) -> Bool
  where C1.Item == C2.Item, C1.Item: Equatable {
    if someContainer.count != anotherContainer.count {
        return false
    }
        
    for i in 0..<someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    return true
}

extension Array: Container {}

var intStack = IntStack()
intStack.push(100)
intStack.push(99)
intStack.push(98)

let intArray = [100, 99, 98]

print("All Items Match: \(allItemsMatch(intStack, intArray))")

extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = self.peek() else {
            return false
        }
        return topItem == item
    }
}

var stack = Stack<Int>()
stack.push(100)
stack.push(99)
stack.push(98)
    
if stack.isTop(98) {
    print("Top element is 98")
} else {
    print("Top element is something else")
}

extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count > 0 && self[0] == item
    }
}

extension Container where Item == Int {
    func median() -> Double? {
        if count == 0 { return nil }
        if count % 2 == 1 { return Double(self[count/2]) }
        let leftMed = self[(count - 1)/2]
        let rightMed = self[count/2]
        return Double(leftMed + rightMed) / 2.0
    }
}

let arr1 = [1, 1, 2]
print("Median of [1, 1, 2] = \(arr1.median()!)")

let arr2 = [1, 1, 2, 2]
print("Median of [1, 1, 2, 2] = \(arr2.median()!)")

/*    
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item]
      where Indices.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}*/

