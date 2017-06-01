#!/usr/bin/env swift

/*
Subscript syntax
subscript(index: Int) -> Int {
    get {
        // return an appropriate subscript value here
    }
    set(newValue) {
        // perform a suitable setting action here
    }
}

Subscript syntax (read-only properties)
subscript(index: Int) -> Int {
    // return an appropriate subscript value here
}
*/

struct Dozen {
    subscript(index: Int) -> Int {
        return index * 12
    }
}
let dozenMultiplier = Dozen()
print(dozenMultiplier[100])

struct ArrayInception {
    var array1 = [1, 2, 3]
    var array2 = [4, 5, 6]
    var array3 = [7, 8, 9]
    subscript(index: Int) -> [Int] {
        switch index {
        case 0:
            return array1
        case 1:
            return array2
        default:
            return array3
        }
    }
    var nestedArray = [[1], [2], [3]]
    var anotherNestedArray: [[Int]] = []
}

var arrayInception = ArrayInception()
print(arrayInception[1][1])

