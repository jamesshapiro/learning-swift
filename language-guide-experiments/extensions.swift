#!/usr/bin/env swift

// Computed Properties:
// ====================

extension Double {
    var ฿: Double { return self * 2_376.62 }
    var eth: Double { return self * 239.02 }
    var dollar: Double { return self }
    var pounds: Double { return self * 1.27 }
    var euro: Double { return self * 1.12 }
    var yuan: Double { return self * 0.15 }
}

let halfOfOne฿ = 0.5.฿
print("0.5฿ is $\(halfOfOne฿)")

let tenPounds = 10.pounds
print("10£ is $\(tenPounds)")

let travelersWallet = 16.฿ + 8.eth + 4.dollar + 2.pounds + 1.euro + 0.5.yuan
print("The traveler has $\(travelersWallet) in his wallet")

// Initializers:
// =============

struct Size {
    var width = 0.0, height = 0.0, breadth = 0.0
}

struct Point {
    var x = 0.0, y = 0.0, z = 0.0
}

struct RectangularPrism {
    var origin = Point()
    var size = Size()
}

let defaultRectangularPrism = RectangularPrism()
let memberwiseRectangularPrism
  = RectangularPrism(origin: Point(x: 3.0, y: 3.0, z: 3.0),
                     size: Size(width: 10.0, height: 10.0, breadth: 10.0))

extension RectangularPrism {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        let originZ = center.z - (size.breadth / 2)
        self.init(origin: Point(x: originX, y: originY, z: originZ),
                  size: size)
    }
}

let centerRectangularPrism
  = RectangularPrism(center: Point(x: 5.0, y: 5.0, z: 5.0),
                     size: Size(width: 11.0, height: 11.0, breadth: 11.0))

print(centerRectangularPrism)
/*
Prints: RectangularPrism(origin: extensions.Point(x: -0.5, y: -0.5, z: -0.5), size: extensions.Size(width: 11.0, height: 11.0, breadth: 11.0))
*/

// Methods:
// ========

extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

4.repetitions {
    print("Hail to the Redskins!")
}

// Mutating Instance Methods:
// ==========================

extension Int {
    mutating func cube() {
        self = self * self * self
    }
}
var someInt = 3
someInt.cube()
print(someInt)

// Subscripts:
// ===========

extension Int {
    subscript(binaryIndex: Int) -> Int {
        var binaryBase = 1
        binaryBase <<= binaryIndex
        return (self & binaryBase) >> binaryIndex
    }
}

for i in 0..<10 {
    print(121[i])
}

// Nested Types:
// =============

extension Int {
    enum Sign {
        case negative, zero, positive
    }
    var sign: Sign {
        switch self {
        case 0:
            return .zero
        case let x where x > 0:
            return .positive
        default:
            return .negative
        }
    }
}

func printIntegerSigns(_ numbers: [Int]) {
    for number in numbers {
        switch number.sign {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}

printIntegerSigns(Array(-3...3))
