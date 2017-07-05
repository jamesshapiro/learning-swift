#!/usr/bin/env swift

// Bit Operations:
// ===============

extension UInt8 {
    func paddedWithLeadingZeroes () -> String {
        let stringVersion = String(self, radix: 2)
        let numZeroes = 8 - stringVersion.characters.count
        return String(repeating: "0", count: numZeroes) + stringVersion
    }
}

let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits
print(invertedBits.paddedWithLeadingZeroes())
// prints: 11110000

let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8  = 0b00111111
let middleFourBits = firstSixBits & lastSixBits
print(middleFourBits.paddedWithLeadingZeroes())
// prints: 00111100

var result: UInt8 = 0
for i in 0..<8 {
    var one: UInt8 = 1
    result |= one << UInt8(i)
}
print(result.paddedWithLeadingZeroes())
//prints: 11111111

let xorArgOne:UInt8 = 0b10010001
let xorArgTwo:UInt8 = 0b10001001
let outputBits = xorArgOne ^ xorArgTwo
print(outputBits.paddedWithLeadingZeroes())
//prints: 00011000

let shiftBits: UInt8 = 4
print((shiftBits << UInt8(1)).paddedWithLeadingZeroes()) // 00001000
print((shiftBits << UInt8(2)).paddedWithLeadingZeroes()) // 00010000
print((shiftBits << UInt8(5)).paddedWithLeadingZeroes()) // 10000000
print((shiftBits << UInt8(6)).paddedWithLeadingZeroes()) // 00000000
print((shiftBits >> UInt8(2)).paddedWithLeadingZeroes()) // 00000001

var tooBig: UInt8 = 255
//tooBig += 1 
// throws an error due to overflow
tooBig = tooBig &+ 1
print(tooBig.paddedWithLeadingZeroes()) // 00000000

// Precedence:
// ===========

print("2 + 3 % 4 * 5 == 17: \(2 + 3 % 4 * 5 == 17)")

// Operator Methods:
// =================

struct Vector3D {
    var x = 0.0, y = 0.0, z = 0.0
}

extension Vector3D {
    static func + (left: Vector3D, right: Vector3D) -> Vector3D {
        return Vector3D(x: left.x + right.x,
                        y: left.y + right.y,
                        z: left.z + right.z)
    }
}

let vector = Vector3D(x: 1.0, y: 2.0, z: 3.0)
let anotherVector = Vector3D(x: 4.0, y: 5.0, z: 6.0)
let yetAnotherVector = vector + anotherVector
print(yetAnotherVector) // Vector3D(x: 5.0, y: 7.0, z: 9.0)

extension Vector3D {
    static prefix func - (vector: Vector3D) -> Vector3D {
        return Vector3D(x: -vector.x, y: -vector.y, z: -vector.z)
    }
}

let positive = Vector3D(x: 3.0, y: 4.0, z: 5.0)
let negative = -positive
let doubleNegative = -negative
print(negative) // Vector3D(x: -3.0, y: -4.0, z: -5.0)
print(doubleNegative) // Vector3D(x: 3.0, y: 4.0, z: 5.0)


