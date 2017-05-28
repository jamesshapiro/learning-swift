#!/usr/bin/env swift

let welcome = "Hail-o, world!"
print(welcome)

// Can assign type to multiple variables
var burgundy, gold: Double
print("type(of: burgundy): \(type(of: burgundy))")
// Unicode variables
let 🐐 = "Colt McCoy"
let 你好 = "你好世界"
// Colt McCoy is the G.O.A.T.
print("let 🐐  = 'Colt McCoy'")

/* This will cause a compile-time error
So swift would appear to be statically typed.
error: cannot assign value of type 'Int' to type 'String'
var redString = "red"
redString = 255
*/

print("Williams", "Moses", "Scherff", separator: ", ", terminator: "\n")
let elitePassRushers = ["Kerrigan", "Murphy", "Galette"]
print(elitePassRushers.joined(separator: ", "))

/* Compile-time error:
error: invalid redeclaration of 'x'
var x = "x"
note: 'x' previously declared here
var x = "y"
*/

// String interpolationp
var bestNflTeam = "Redskins"
print("Hail To The \(bestNflTeam)!")

// Swift allows nested multiline comments
/* Nested /* Multiline /* Comment */ */ */
var eaglesWinLossVsSkinsSinceDec2014 = -5
print("Eagles W/L vs. the Redskins, Dec 2014 to Jan 2017: \(eaglesWinLossVsSkinsSinceDec2014)")


/* Compile-time errors:

error: cannot convert value of type 'Int' to specified type 'UInt8'
var negativeIntToUInt: UInt8 = eaglesWinLossVsSkinsSinceDec2014
print(negativeIntToUInt)

error: arithmetic operation '127 + 1' (on type 'Int8') results in an overflow
var eaglesCombinedWonderlicScore = Int8.max + 1
*/

let NFC_East = ["Cowboys", "Redskins", "Eagles", "Giants"]
print("\(NFC_East).max()!: \(NFC_East.max()!)")
print("\(NFC_East).min()!: \(NFC_East.min()!)")

/* 2^63 -1 == 9223372036854775807
 My computer is 64-bit, so these statement yield:
 "9223372036854775807" and "18446744073709551615",
 respectively */
print("Int.max: \(Int.max)")
print("UInt.max: \(UInt.max)")

let winsIn2016 = 8 + 0.5
print("'8 + 0.5' is inferred to be of type: \(type(of: winsIn2016))")
print("print(0b1111001) yields: \(0b1111001)")
// output: print(0b1111001) yields: 121

var flt: Float = 5
print(flt)

/* Formatting large numbers with underscores for 
 readability As of 5/25 */
var apple_incs_market_cap = 799_850_000_000

/* Mixing UInt operations:

 14> let twoThousand: UInt16 = 2_000
twoThousand: UInt16 = 2000
 15> let seventeen: UInt8 = 17
seventeen: UInt8 = 17
 16> let twoThousandMod17 = twoThousand % seventeen
error: repl.swift:16:36: error: binary operator '%' cannot be applied to operands of type 'UInt16' and 'UInt8'
let twoThousandMod17 = twoThousand % seventeen
                       ~~~~~~~~~~~ ^ ~~~

repl.swift:16:36: note: overloads for '%' exist with these partially matching parameter lists: (UInt8, UInt8), (UInt16, UInt16)
let twoThousandMod17 = twoThousand % seventeen

However, the below example is permitted:
*/

let twoThousand: UInt16 = 2_000
let one: UInt8 = 1
let twoThousandAndOne = twoThousand + UInt16(one)
print("type(of: twoThousandAndOne): \(type(of: twoThousandAndOne))")

/* The following causes a compile-time error:
 let three = 3
 let pointOneFourOneFiveNine = 0.14159
 let pi = three + pointOneFourOneFiveNi

 HOWEVER, note that var x = 3 + 0.14159 is perfectly 
 legal and will create a Double.

 Casting solves the problem:
 */

let three = 3
let pointOneFourOneFiveNine = 0.14159
let pi = Double(three) + pointOneFourOneFiveNine

/* Funny edge case:

Int(3.9999999999999997) == 3
Int(3.9999999999999998) == 4

Swift docs say that casting from a Float to an
Int always truncates. However, when we're dealing
with literals, the literal first gets converted to
a valid Double (or other type). Then the Double
gets truncated into an Int.
*/

//RGBA
typealias Pixel = (UInt16, UInt16, UInt16, UInt16)
// typealias has access to the methods of the thing being aliased
var pix: Pixel = (1, 17, 5, 2)
print(pix.1)

let possibleNumber = "24"
let convertedNumber = Int(possibleNumber)
print(type(of: convertedNumber), "| number: \(convertedNumber!)")

let invalidNumber = "jno24"
let invalidConvertedNumber = Int(invalidNumber)
print(type(of: invalidConvertedNumber))
/* The following line causes this *run-time* error:
fatal error: unexpectedly found nil while unwrapping an Optional value
print(invalidConvertedNumber!)
*/

/* This causes a compile-time error:
error: nil cannot initialize specified type 'Int'
note: add '?' to form the optional type 'Int?'
var x: Int  = nil
*/

/* Optional variables are set to nil by default
 however, constants can have their value reset to
 something other than nil */
var giantsPlayerWhoScoredAbove18onTheWonderlic: String?
let redskinsPlayerWhoScoredBelow18onTheWonderlic: String?
redskinsPlayerWhoScoredBelow18onTheWonderlic = "Robert Griffin III, W.O.A.T"
print(redskinsPlayerWhoScoredBelow18onTheWonderlic!)

if giantsPlayerWhoScoredAbove18onTheWonderlic != nil {
    print("A Giants player scored above 18 on the Wonderlic")
}

if var actualNumber = Int(possibleNumber) {
    print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
    actualNumber *= 2
    print("When multiplied by two, that integer is: \(actualNumber)")
} else {
    print("\"\(possibleNumber)\" could not be converted to an integer")
}

if let actualNumber = Int(invalidNumber) {
    print("\"\(invalidNumber)\" has an integer value of \(actualNumber)")
} else {
    print("\"\(invalidNumber)\" could not be converted to an integer")
}

if "cowboys" < "eagles", "eagles" < "giants", "giants" <  "redskins" {
    print("Swift can use commas in place of && for multiple boolean conditions")
}

let assumedString: String! = "An implicitly unwrapped optional string."
print("type of a String!:  \(type(of: assumedString))")
print("type of Int(possibleNumber)!:  \(type(of: Int(possibleNumber)!))")

let RG3sEgo = UInt64.max

/* 
Causes a crash / run-time error:
assert(RG3sEgo < UInt64.max, "RG3's ego can't be that inflated")
*/


