#!/usr/bin/env swift

// Constants, variables, properties, and subscripts:
// =================================================

// Getters and setters

struct TrackedString {
    private(set) var numberOfEdits = 0
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
}

var stringToEdit = TrackedString()
stringToEdit.value = "Hail to the Redskins!"
stringToEdit.value += " Hail Victory!"
stringToEdit.value += " Braves on the Warpath!"
stringToEdit.value += " Fight for ol' DC!"
print("The number of edits is \(stringToEdit.numberOfEdits)")
// Prints "The number of edits is 4"
