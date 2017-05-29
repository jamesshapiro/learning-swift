#!/usr/bin/env swift

// *** ARRAYS ***
// ==============

// mutability experiment: try to mutate the array in
// an immutable array of arrays

var nfcEastTeams = ["DAL", "NYG", "PHI", "WAS"]
var nfcWestTeams = ["ARI", "STL", "SEA", "SF"]
let nfcEastWest = [nfcEastTeams, nfcWestTeams]

// Prints [["DAL", "NYG", "PHI", "WAS"], ["ARI", "STL", "SEA", "SF"]]
print(nfcEastWest)
nfcWestTeams[1] = "LA"
// (!) Prints [["DAL", "NYG", "PHI", "WAS"], ["ARI", "STL", "SEA", "SF"]]
print(nfcEastWest)
// Prints ["ARI", "LA", "SEA", "SF"]
print(nfcWestTeams)

// Interesting! Seems like the members of the arrays
// are recursively copied when nfcEastWest is
// initialized.

// empty array initialization syntax
var someInts = [Int]()
/* 
produces compile-time error:
error: cannot assign value of type '[String]' to type '[Int]'
someInts = [String]()
*/

var keepinItOneHundred = Array(repeating: 100.0, count: 100)
print(keepinItOneHundred)

var doubleArray: [Double] = [1, 2]
print(doubleArray)

doubleArray.append(3)
doubleArray += [4]
print(doubleArray)

/* element-wise addition of two arrays*/
let result = zip(nfcEastTeams, nfcWestTeams).map(+)
print(result)

// replace a subrange of an array with a different subrange
nfcWestTeams[2...3] = ["SEASF"]
print(nfcWestTeams)
nfcWestTeams[1...2] = []
print(nfcWestTeams)
nfcWestTeams += ["LA", "SEA", "SF"]

nfcWestTeams.insert("Los Angeles Xtreme", at: 0)
print(nfcWestTeams)
let niners = nfcWestTeams.removeLast()
print(niners)

// Swift has enumerated like Python:
for (index, value) in nfcWestTeams.enumerated() {
    print(index, value)
}

// *** SETS ***
// ============

let declarationOfIndependencePreamble = "We hold these truths to be self-evident, that all men are created equal, that they are endowed by their Creator with certain unalienable Rights, that among these are Life, Liberty and the pursuit of Happiness. That to secure these rights, Governments are instituted among Men, deriving their just powers from the consent of the governed, That whenever any Form of Government becomes destructive of these ends, it is the Right of the People to alter or to abolish it, and to institute new Government, laying its foundation on such principles and organizing its powers in such form, as to them shall seem most likely to effect their Safety and Happiness. Prudence, indeed, will dictate that Governments long established should not be changed for light and transient causes; and accordingly all experience hath shewn, that mankind are more disposed to suffer, while evils are sufferable, than to right themselves by abolishing the forms to which they are accustomed. But when a long train of abuses and usurpations, pursuing invariably the same Object evinces a design to reduce them under absolute Despotism, it is their right, it is their duty, to throw off such Government, and to provide new Guards for their future security."

/* Note: this works but you have to "import Foundation which takes FOREVER"
let preambleAsWordArray =
  declarationOfIndependencePreamble.components(separatedBy: " ")
print("num words in preamble: \(preambleAsWordArray.count)")

let preambleAsSet = Set(preambleAsWordArray)
print("num *distinct* words in preamble: \(preambleAsSet.count)")

prints: 
num words in preamble: 202
num *distinct* words in preamble: 132
*/

var letters = Set<Character>()
print("letters is of type \(type(of: letters)) with \(letters.count) items.")
// Prints "letters is of type Set<Character> with 0 items."

let oneOrange = Set(["orange", "grape", "banana", "orange", "orange"])
let tropical = Set(["mango", "banana", "kiwi"])
print(oneOrange)
// set ops include union, intersection, subtraction, and symmetric difference
// is-subset, is-superset, is-disjoint-with
print(oneOrange.union(tropical))

//*** DICTIONARIES ***
//====================

var englishToIntValue = [String: Int]()
englishToIntValue["one"] = 1
englishToIntValue["two"] = 2

var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports.removeValue(forKey: "YYZ")
print(airports)




