#!/usr/bin/env swift

struct PokerCard {
    // nest Suit enumeration
    enum Suit: Character {
        case clubs = "♣", diamonds = "♢", hearts = "♡", spades = "♠"
    }

    // nested Rank enumeration
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine,
             ten, jack, queen, king, ace
        struct Values {
            let first: Int, second: Int?
        }
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 14)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
    }
            
    //PokerCard properties and methods
    let rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue), "
        output += "value is \(rank.values.first)"
        if let second = rank.values.second {
            output += " or \(second)"
        }
        return output
    }
}

let aceOfClubs = PokerCard(rank: .ace, suit: .clubs)
print("The Ace Of Clubs: \(aceOfClubs.description)")
// Prints: The Ace Of Clubs: suit is ♣, value is 1 or 14

let spadesSymbol = PokerCard.Suit.spades.rawValue
let aceValue = PokerCard.Rank.king.rawValue
print("king of spades: \(aceValue)\(spadesSymbol)")


