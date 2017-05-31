#!/usr/bin/env swift

// stored property constant structure experiment
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
/* causes error
error: cannot assign to property: 'rangeOfFourItems' is a 'let' constant
rangeOfFourItems.firstValue = 6
*/
var alsoRangeOfFourItems = rangeOfFourItems
// no error
alsoRangeOfFourItems.firstValue = 6

// computed properties
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

// Note: area is a read-only computer property
struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set(newCenter) {
            origin.x = newCenter.x - (size.width / 2)
            origin.y = newCenter.y - (size.height / 2)
        }
    }
    var area: Double {
        get {
            return size.width * size.height
        }
    }
}

// Computed property with name of setter parameter omitted
struct RectWithNewValue {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return Point(x: centerX, y: centerY)
        }
        set {
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
    var area: Double {
        get {
            return size.width * size.height
        }
    }
}

// Read-Only Computed Property without "get"
struct HyperCube {
    var width = 0.0, height = 0.0, depth = 0.0, time = 0.0
    var timeVolume: Double {
        return width * height * depth * time
    }
}

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalSteps to \(newValue)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            } else {
                print("Uh-oh! You've lost a step!")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 300
stepCounter.totalSteps = 400
stepCounter.totalSteps = 397

// can create static class variables that are the same for every
// instance of a class. These are referred to as "Type Properties"
// in Swift. See "Type Property Syntax" section of the "Properties"
// chapter of the Swift language guide for more details, but basically
// you just preface the variable with "static". WOrks for structs, enums,
// and classes.

/*
class SomeClass {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 27
    }
    class var overrideableComputedTypeProperty: Int {
        return 107
    }
}
*/

struct SomeStructure {
    static var storedTypeProperty = "Some value."
    static var computedTypeProperty: Int {
        return 1
    }
}

// to change storedTypeProperty
SomeStructure.storedTypeProperty = "But see, it's the other way"
let someStructure = SomeStructure()
print(SomeStructure.storedTypeProperty)
