#!/usr/bin/env swift

let coltMcCoy = "G.O.A.T"
var RG3 = "Garbage"
RG3 = "Complete " + RG3
print("Colt McCoy is the \(coltMcCoy)")
print("RG3 is \(RG3)")

// Poker Unicode -- useful for future project
let blackHeart = "\u{2665}"
let blackSpade = "\u{2664}"
let blackClub = "\u{2667}"
let blackDiamond = "\u{2666}"
print(blackDiamond, blackSpade, blackClub, blackHeart)

// prints true
print("" == String())
print("".isEmpty)

var variableString = "Horse"
variableString += " and carriage"
variableString += " is for hire"

/* 
causes compile-time error:
error: left side of mutating operator isn't mutable: 'constant' 
is a 'let' constant

let constant = "constant"
constant += " change!"
*/

/*

This is currently broken (delaying fixing this until I read the
Functions and Methods section) but the point of this example is 
to show how Swift copies Strings "by value" when they are used 
in functions/methods

var chernobyl = "radioactive"
func attemptToMutateString(string: String) {
    string += " mutation!"
}

attemptToMutateString(chernobyl)
print(chernobyl)
*/

// C.f. Python where you can simply iterate over the characters
// in a string with for-in. Here you have to use .characters .
// This could just be the unavoidable cost of Unicode flexibility
for character in "YTMND".characters {
    print(character)
}

// In Swift a string is an array of Unicode scalars
// Each character in a Swift String is an "extended grapheme cluster"
// An "extended grapheme cluster is a sequence of one or more Unicode
//    scalars that (when combined) produce a single human-readable
//    character.
let combinedEAcute: Character = "\u{65}\u{301}"
let stringStrung = String([combinedEAcute])

// Seems bulky compared to Python's len(stringStrung)
print(stringStrung.characters.count)

// Indexing
print("Indexing:")
var hail = "Hail to the Redskins"
print(hail[hail.startIndex])
print(hail[hail.index(before: hail.endIndex)])
print(hail[hail.index(after: hail.startIndex)])
let index = hail.index(hail.startIndex, offsetBy: 12)
print(index, type(of: index))
print(hail[index])
for index in hail.characters.indices {
    print("\(hail[index]) ", terminator: "")
}
print("")

// TODO using index(before:) and index(after:) on Array,
// Dictionary, and Set. See what happens

let washington = "Washington "
hail.insert(contentsOf: washington.characters, at: hail.index(hail.startIndex,
                                                   offsetBy: 12))
print(hail)
hail.insert(contentsOf: "! Hail Victory!".characters, at: hail.endIndex)
print(hail)

// TODO: learn line overhang conventions
let range = hail.index(hail.startIndex, offsetBy: 12) ..< hail.index(hail.startIndex, offsetBy: 12 + washington.characters.count)
hail.removeSubrange(range)
print(hail)
if hail.hasPrefix("Hail") {
    print("Hail")
}

print(type(of: washington.utf8))
for char in blackHeart.utf8 {
    print("\(char) ", terminator: "")
}
print("")
