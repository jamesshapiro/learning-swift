#!/usr/bin/env swift

print("class")

// 4K
struct Resolution {
    var width = 3840
    var height = 2160
}

// high FPS
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 100.0
    var name: String?
}

let vga = Resolution(width: 640, height: 480)
/* produces compile-time error:
error: argument 'width' must precede argument 'height'
let vgaTranspose = Resolution(height: 480, width: 640)
print(vgaTranspose)
*/

// structures are value types:
let hd = Resolution(width: 1920, height:1080)
var cinema = hd
cinema.height = 180
// prints Resolution(width: 1920, height: 1080)
print(hd)
// prints Resolution(width: 1920, height: 180)
print(cinema)

/* this doesn't work. TODO: investigate why
let teneightyp = VideoMode(resolution: hd,
                           interlaced: false,
                           frameRate: 60.0,
                           name: "1080p")
                           */

// classes are ''reference'' types
let tenEightyP = VideoMode()
tenEightyP.resolution = hd
tenEightyP.interlaced = false
tenEightyP.name = "1080p"
tenEightyP.frameRate = 60.0

let alsoTenEightyP = tenEightyP
alsoTenEightyP.name = "eleven eighty p"
// prints: eleven eighty p
print(tenEightyP.name!)
// prints: eleven eighty p
print(alsoTenEightyP.name!)

// equality
tenEightyP.name = "1080p"

let tenEightyClone = VideoMode()
tenEightyClone.resolution = hd
tenEightyClone.interlaced = false
tenEightyClone.name = "1080p"
tenEightyClone.frameRate = 60.0

print("tenEightyP === alsoTenEightyP: \(tenEightyP === alsoTenEightyP)")
print("tenEightyP === tenEightyClone: \(tenEightyP === tenEightyClone)")

/* causes compile-time error:
error: binary operator '==' cannot be applied to two 'VideoMode' operands
print("tenEightyP == alsoTenEightyP: \(tenEightyP == alsoTenEightyP)")
print("tenEightyP == tenEightyClone: \(tenEightyP == tenEightyClone)")
*/

// TODO: run experiment on inout variables for functions to see if you can
// change which object a variable(pointer) points to inside of a function
