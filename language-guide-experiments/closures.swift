#!/usr/bin/env swift

let names = ["Stacy", "Jonathan", "Terrell", "Ziggy", "Matt"]
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

var reversedNames = names.sorted(by: backward)
print(reversedNames)

//shorter -- use closure
reversedNames =
  names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
print(reversedNames)

//shorter -- omit ''->'' and parameter/return types
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
print(reversedNames)

//shorter -- omit the word ''return'', since it's a
//single-expression closure
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
print(reversedNames)

//shorter -- shorthand argument names
reversedNames = names.sorted(by: { $0 > $1 } )
print(reversedNames)

// shortest -- operator methods. Ridiculous
reversedNames = names.sorted(by: >)
print(reversedNames)

// as a trailing closure
reversedNames = names.sorted() { $0 > $1 }
print(reversedNames)

/* operator methods don't work for trailing closures
compile-time error:
error: unary operator cannot be separated from its operand
reversedNames = names.sorted() { > }
print(reversedNames)
*/

let digitNames = [
    0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]
let numbers = [16, 58, 510]
print(numbers.map() { (number) -> String in
    // this line is necessary because by default ''number''
    // the closure parameter is a constant
    var number = number
    var output = ""
    repeat {
        output = digitNames[number % 10]! + output
        number /= 10
    } while number > 0
    return output
})

// reminds me a bit of Python generators
func makeIncrementer(forIncrement amount: Int,
                     startingAt runningTotal: Int) -> () -> Int {
    var runningTotal = runningTotal - amount
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let counter = makeIncrementer(forIncrement: 1, startingAt: 1)
let counter2 = makeIncrementer(forIncrement: 5, startingAt: 10)

print(counter())
print(counter())
print(counter())
print(counter())
print(counter())

print(counter2())
print(counter2())
print(counter2())

let counter3 = counter2
print(counter3())


/* Causes compile-time error:
error: nested function cannot capture inout parameter and escape
func makeIncrementer2(forIncrement amount: Int,
                      startingPoint runningTotal: inout Int) -> () -> Int {
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

var x = 1
var counter3 = makeIncrementer2(forIncrement: 1, startingPoint: &x)
var counter4 = makeIncrementer2(forIncrement: 1, startingPoint: &x)
print(counter3())
print(counter4())
print(x)
*/

