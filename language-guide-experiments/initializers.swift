#!/usr/bin/env swift

struct BankAccount {
    var balance: Int
    init() {
        balance = 100
    }
}

var account = BankAccount()
print("The default account balance is $\(account.balance)")

struct InternationalAccount {
    var usDollarsBalance: Double
    init(fromDollars usDollars: Double) {
        usDollarsBalance = usDollars
    }
    init(fromBaht thaiBaht: Double) {
        usDollarsBalance = thaiBaht / 34.0
    }
    init(_ usDollars: Double) {
        usDollarsBalance = usDollars
    }
}

let aLotOfBaht = InternationalAccount(fromBaht: 68_000_100)
let notALotOfBaht = InternationalAccount(fromBaht: 100)

print(aLotOfBaht.usDollarsBalance)
print(notALotOfBaht.usDollarsBalance)

class UndraftedFreeAgent {
    let fullName: String
    // this property is optional because the UDFA
    // may never get signed and may earn nothing.
    // In fact, this is usually what happens.
    var salary: Int?
    init(fullName: String) {
        self.fullName = fullName
    }
    func displayName() {
        print(fullName)
    }
}

let udfa = UndraftedFreeAgent(fullName: "Robert 'Fat Rob' Kelley")
udfa.displayName()
// We signed him!
udfa.salary = 540_000

class NaturalNumbers {
    var one = 1
    var two = 2
    var three = 3
    var etCetera: String?
}
var naturalNumbers = NaturalNumbers()

struct Computer {
    var memoryInGB = 16
    var storageInTB = 2.0
}
let cheapDell = Computer(memoryInGB: 8, storageInTB: 0.256)
print(cheapDell.storageInTB)

struct Size {
    var width = 0.0, height = 0.0
}

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(origin: Point(x: originX, y: originY), size:size)
    }
}
let defaultRect = Rect()
let originRect = Rect(origin: Point(x: 0.0, y: 0.0),
                      size: Size(width: 100.0, height: 80.0))
let centerRect = Rect(center: Point(x: 50.0, y: 40.0),
                      size: Size(width: 100.0, height: 80.0))
print(centerRect.origin.x, centerRect.origin.y)

class MultiplyRoot {
    var value = 1
    init() { }
    init(value: Int) {
        self.value = value
    }
}

class MultiplyWrapper: MultiplyRoot {
    var multiplyWrapper: MultiplyWrapper?
    var multiplier: Int
    override init() {
        self.multiplier = 1
        super.init()
    }
    override init(value: Int) {
        self.multiplier = 1
        super.init(value: value)
        compute_value()
    }
    convenience init(wrapped: MultiplyWrapper) {
        self.init()
        self.multiplyWrapper = wrapped
    }
    func compute_value() {
        if let mw = multiplyWrapper {
            self.value = mw.value * self.multiplier
        } else {
            self.value *= self.multiplier
        }
    }
}

class Animal {
    var numberOfLegs = 0
    var description: String {
        return "I am a \(numberOfLegs)-legged animal!"
    }
}

let oyster = Animal()
print("oyster: \(oyster.description)")

class Elephant: Animal {
    override init() {
        super.init()
        numberOfLegs = 4
    }
}

let elephant = Elephant()
print("elephant: \(elephant.description)")

class Beverage {
    var name: String
    init(name: String) {
        self.name = name
    }
    convenience init() {
        self.init(name: "[Liquid]")
    }
}

let namedAlcoholicBeverage = Beverage(name: "rum")
let mysteryBeverage = Beverage()

class MixedDrinkIngredient: Beverage {
    var quantityInMilliliters: Int
    init(name: String, quantity: Int) {
        self.quantityInMilliliters = quantity
        super.init(name: name)
    }
    override convenience init(name: String) {
        self.init(name: name, quantity: 250)
    }
}

/* Because it provides an implementation of all of its
 superclass's designated initializers, MixedDrinkIngredient
 inherits its superclass's convenience and designated 
 initializers: */
// Convenience
let mysteryIngredient = MixedDrinkIngredient()
print(mysteryIngredient.name,
      mysteryIngredient.quantityInMilliliters)
let tonicWater = MixedDrinkIngredient(name: "Tonic Water")
let vodka = MixedDrinkIngredient(name: "Vodka", quantity: 150)

class ShoppingListItem: MixedDrinkIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantityInMilliliters) x \(name)"
        output += purchased ? "✔" : " ✘"
        return output
    }
}
/* Because it provides a default value for all of the
 properties it introduces and does not define any 
 initializers itself, ShoppingListItem automatically 
 inherits all of the designated and convenience 
 initializers from its superclass. */

let items = [
  ShoppingListItem(),
  ShoppingListItem(name: "Tonic"),
  // Note: terminal comma is not an issue
  ShoppingListItem(name: "Vodka", quantity: 150),
]
for item in items {
    print(item.description)
}

struct Vegetable {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someVegetable = Vegetable(species: "Taraxacum officinale")
let nilVegetable = Vegetable(species: "")

// Failable Initializers for Enumerations
enum OffensivePlayer {
    case offensiveLineman, quarterback, wideReceiver, runningBack, tightEnd
    init?(abbreviation: String) {
        switch abbreviation {
        case "OL":
            self = .offensiveLineman
        case "QB":
            self = .quarterback
        case "WR":
            self = .wideReceiver
        case "RB":
            self = .runningBack
        case "TE":
            self = .tightEnd
        default:
            return nil
        }
    }
}

let runningBack = OffensivePlayer(abbreviation: "RB")
if runningBack != nil {
    print("RB is a valid abbreviation for an offensive player")
}
// invalid because cornerbacks play defense     
let cornerback = OffensivePlayer(abbreviation: "CB")
if cornerback == nil {
    print("CB is not a valid abbreviation for an offensive player")
}

enum OffensivePosition: String {
    case offensiveLineman = "OL", quarterback = "QB", wideReceiver = "WR",
         runningBack = "RB", tightEnd = "TE"
}

let rb = OffensivePosition(rawValue: "RB")
if runningBack != nil {
    print("RB is a valid rawValue for an offensive position")
}
// invalid because cornerbacks play defense     
let cb = OffensivePosition(rawValue: "CB")
if cornerback == nil {
    print("CB is not a valid abbreviation for an offensive position")
}

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

let cartItem1 = CartItem(name: "", quantity: 0)
let cartItem2 = CartItem(name: "", quantity: 1)
let cartItem3 = CartItem(name: "product", quantity: 0)
let cartItem4 = CartItem(name: "product", quantity: 1)
print(cartItem1 == nil)
print(cartItem2 == nil)
print(cartItem3 == nil)
print(cartItem4 != nil)

class Document {
    var name: String?
    init() {}
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class AutomaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
    override init(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}

class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

enum ChessboardColor {
    case black, white
}

struct Chessboard {
    let boardColors: [ChessboardColor] = {
        var temporaryBoard = [ChessboardColor]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                isBlack ?
                  temporaryBoard.append(ChessboardColor.black) :
                  temporaryBoard.append(ChessboardColor.white)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temporaryBoard
    }()
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column] == ChessboardColor.black
    }
}
let board = Chessboard()

print(board.squareIsBlackAt(row: 0, column: 0) == false)
print(board.squareIsBlackAt(row: 0, column: 1) == true)
print(board.squareIsBlackAt(row: 1, column: 0) == true)
print(board.squareIsBlackAt(row: 1, column: 1) == false)

        
