#!/usr/bin/env swift

enum NfcEastTeams {
    case redskins
    case cowboys
    case eagles
    case giants
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, saturn, uranus, neptune, pluto
}

var worstNfcEastTeam = NfcEastTeams.giants
worstNfcEastTeam = .cowboys
let bestNfcEastTeam = NfcEastTeams.redskins
let myFavoriteTeam = bestNfcEastTeam

switch myFavoriteTeam {
case .redskins:
    print("Hail to the Redskins!")
case .cowboys:
    print("Have you even been to Dallas?")
case .eagles:
    print("Sooooo many rings...")
case .giants:
    print("Going to Miami the week before playoffs is a great idea")
}

// enums with arguments:
// Associated Values:
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

// enums can have raw values (e.g.: Character)
// -- String, Character, Int, and Float
enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriageReturn = "\r"
}

/* error: raw value for enum case must be a literal
TODO: think up another example
enum ArbitraryNumbers: Array {
    case one = [1]
    case two = [2]
    case three = [3]
}
*/

// implicitly assigned raw values

enum implicitlyAssignedRaws: Int {
    case one = 1, two, three, four, five, six, seven, eight, nine
}

enum CompassPoint: String {
    case north, south, east, west
}

let directionToReachSanta = CompassPoint.north.rawValue
print(directionToReachSanta, type(of: directionToReachSanta))
// directionToReachSanta is "north"


//recursive enumeration
// useful for tree-like structures
indirect enum Node {
    case empty
    case child(Int)
    case parent(Int, Node, Node)
}

var grandchildLeftLeft = Node.child(4)
var grandchildLeftMiddle = Node.child(5)
var grandchildMiddleRight = Node.child(6)
var grandchildRightRight = Node.child(7)
var childLeft = Node.parent(2, grandchildLeftLeft, grandchildLeftMiddle)
var childRight = Node.parent(3, grandchildMiddleRight, grandchildRightRight)
var root = Node.parent(1, childLeft, childRight)

func printPreorder(_ node: Node) {
    switch node {
    case let .child(value):
        print(value, terminator: " ")
    case let .parent(value, leftChild, rightChild):
        printPreorder(leftChild)
        print(value, terminator: " ")
        printPreorder(rightChild)
    case .empty:
        return
    }
}

printPreorder(root)
print("")


