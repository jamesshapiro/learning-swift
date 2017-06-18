#!/usr/bin/env swift

class Player {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let dj = Player()

// causes runtime error:
// let roomCount = dj.residence!.numberOfRooms

if let roomCount = dj.residence?.numberOfRooms {
    print("DJ Swearinger's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

dj.residence = Residence()

if let roomCount = dj.residence?.numberOfRooms {
    print("DJ Swearinger's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}

class Player2 {
    var residence: Residence2?
}

class Residence2 {
    var rooms = [Room]()
    var numberOfRooms: Int {
        return rooms.count
    }
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    func buildingIdentifier() -> String? {
        if let buildingNumber = buildingNumber, let street = street {
            return "\(buildingNumber) \(street)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

let deshazor = Player2()
if let roomCount = deshazor.residence?.numberOfRooms {
    print("Deshazor's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."

let someAddress = Address()
someAddress.buildingNumber = "404"
someAddress.street = "Unfound Road"
// Fails because residence is nil:
deshazor.residence?.address = someAddress

if let roomCount = deshazor.residence?.numberOfRooms {
    print("Deshazor's residence has \(roomCount) room(s).")
} else {
    print("Unable to retrieve the number of rooms.")
}
// Prints "Unable to retrieve the number of rooms."

func createAddress() -> Address {
    print("Function was called.")

    let someAddress = Address()
    someAddress.buildingNumber = "404"
    someAddress.street = "Unfound Road"

    return someAddress
}
// Nothing printed because right-side is not
// evaluated because residence is nil
deshazor.residence?.address = createAddress()

if deshazor.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms.")
} else {
    print("It was *not* possible to print the number of rooms.")
}
// Prints "It was *not* possible to print the number of rooms."

if let firstRoomName = deshazor.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}

deshazor.residence?[0] = Room(name: "Garage")

let deshazorsHouse = Residence2()
deshazorsHouse.rooms.append(Room(name: "Living Room"))
deshazorsHouse.rooms.append(Room(name: "Kitchen"))
deshazor.residence = deshazorsHouse

if let firstRoomName = deshazor.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}
                            
var areaCodes = ["ThreeOhOne": [4, 0, 1], "TwoOhTwo": [2, 0, 2]]
areaCodes["ThreeOhOne"]?[0] = 3
areaCodes["TwoOhTwo"]?[0] += 200
areaCodes["TwoOneTwo"]?[0] = 2

if let deshazorsStreet = deshazor.residence?.address?.street {
    print("Deshazor's street name is \(deshazorsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints: "Unable to retrieve the address."

let deshazorsAddress = Address()
deshazorsAddress.buildingName = "The Deshazor"
deshazorsAddress.street = "Deshazor Street"
deshazor.residence?.address = deshazorsAddress

if let deshazorsStreet = deshazor.residence?.address?.street {
    print("Deshazor's street name is \(deshazorsStreet).")
} else {
    print("Unable to retrieve the address.")
}

if let buildingIdentifier = deshazor.residence?.address?.buildingIdentifier() {
    print("Deshazor's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe =
     deshazor.residence?.address?.buildingIdentifier()?.hasPrefix("The ") {
    if beginsWithThe {
        print("Deshazor's building identifier begins with \"The\".")
    } else {
        print("Deshazor's building identifier does not begin with \"The\".")
    }
}
// Prints "Deshazor's building identifier begins with "The"."
