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
