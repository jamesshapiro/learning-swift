#!/usr/bin/env swift

func greet(person: String) -> String {
    let greeting = "Hello, " + person + "!"
    return greeting
}

print(greet(person: "world"))

/* built-ins like "type" seem not to be
overridable, and they don't even warn you
that there's already a function with that 
name at compile-time

Or maybe they are overridable, but when the
default argument is a generic object class
the compiler defaults to that unless you 
explicitly override it

func type(of: String) -> String {
    return "Hello override!"
}

// Prints: "String"
print(type(of: "object"))
*/

func printAndCount(string: String) -> Int {
    print(string)
    return string.characters.count
}

/* compile-time warning:
warning: result of call to 'printAndCount(string:)' is unused
printAndCount(string: "Hail to the Redskins")

HOWEVER:
_ = printAndCount(string: "Hail to the Redskins")
works just fine.
*/


func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}

// No warning, but had to use that other functions to subdue it
printWithoutCounting(string: "Hail to the Redskins")

// functions can return tuples

// functions can have argument labels AND parameter names
func greet(person: String, from hometown: String) -> String {
    return "Hello \(person)!  Glad you could visit from \(hometown)."
}
// Prints "Hello Bill!  Glad you could visit from Cupertino."
print(greet(person: "Bill", from: "Cupertino"))

func arithmeticMean(_ numbers: Double...) -> Double {
    guard numbers.count > 0 else {
        return 0.0
    }
    var total: Double = 0
    total += numbers.reduce(0, +)
    return total / Double(numbers.count)
}

print(arithmeticMean(169, 191))
print(arithmeticMean())

// inout parameters
func double(_ arg: inout Int) {
    arg *= 2
}

var num = 1
double(&num)
double(&num)
double(&num)
double(&num)
double(&num)
double(&num)
print(num)

// returning a function from a function:
func stepForward(_ input: Int) -> Int {
    return input + 1
}
func stepBackward(_ input: Int) -> Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}
var currentValue = 3
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
print("Counting to zero:")
// Counting to zero:
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")


// experiment, a function that takes a function as input
// and returns a function as output
func negateInt(_ int: Int) -> Int {
    return -1 * int
}
print(negateInt(-5))

func identityFunction(_ closure: @escaping (Int) -> Int) -> (Int) -> Int {
    return closure
}

let alsoNegateInt = identityFunction(negateInt)
print(alsoNegateInt(-5))

func applyTwice(_ closure: @escaping (Int) -> Int) -> (Int) -> Int {
    func applyTwicer(int: Int) -> Int {
        return closure(closure(int))
    }
    return applyTwicer
}

func squareX(x: Int) -> Int {
    return x * x
}

let biquadrate = applyTwice(squareX)
let largestNonCrashingQuarticArgument = 55108
for i in 1...largestNonCrashingQuarticArgument {
    print(biquadrate(i))
}
/* Causes a run-time error on my computer
for i in 1...(largestNonCrashingQuarticArgument+1) {
    print(biquadrate(i))
}
*/

/* Nested functions example
func chooseStepFunction(backward: Bool) -> (Int) -> Int {
    func stepForward(input: Int) -> Int { return input + 1 }
    func stepBackward(input: Int) -> Int { return input - 1 }
    return backward ? stepBackward : stepForward
}

var currentValue = -4
let moveNearerToZero = chooseStepFunction(backward: currentValue > 0)
// moveNearerToZero now refers to the nested stepForward() function
while currentValue != 0 {
    print("\(currentValue)... ")
    currentValue = moveNearerToZero(currentValue)
}
print("zero!")
*/

