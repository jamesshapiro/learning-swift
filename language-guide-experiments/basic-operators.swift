#!/usr/bin/env swift

var bigBadWolf = 2
/* prints:
1
2
*/
for val in 1..<3 {
    print(val)
}
/* prints:
1
2
3
*/
for val in 1...3 {
    print(val)
}

/* Python-esque swapping */
var x = 10
var y = 20
(x, y) = (y, x)
print(x, y)

var future_sack_leader = "Ryan " + "Anderson"

/* % is remainder, not modulus, e.g. */
var remainderNotModulus = -9 % 4
print(remainderNotModulus)

var eight_bit: UInt8 = 255
print(eight_bit)

eight_bit = eight_bit &+ 1
print(eight_bit)

print((1, "zebra") < (2, "apple"))
print((3, "apple") < (3, "bird"))
print((4, "dog") == (4, "dog"))

/* Bizarre tuple behavior

NOTE

The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.
*/
print((1,2,3,4,5,6) < (1,2,3,4,5,6))

/* 
compile-time error: binary operator '<' cannot be applied to two '(Int, Int, Int, Int, Int, Int, Int)' operands

print((1,2,3,4,5,6,7) < (1,2,3,4,5,6,8))
*/

var jno24 = "jno24"
var intOptional = Int(jno24)
var num = (intOptional ?? 25)
// prints 25
print(num)

var oneThroughTen = 1...10
var oneThroughNine = 1..<10


let names = ["Hopkins", "Way", "Everett", "Sundberg"]
// going through array indices
for i in 0..<names.count {
    print("Person \(i + 1) is called \(names[i])")
}
// swift has for-in loops like Java or Python.
for name in names {
    print(name)
}

// Logical operators:
// "||" has lower precedence than "&&", as with Java
