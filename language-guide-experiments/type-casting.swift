#!/usr/bin/env swift

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}

class Movie: MediaItem {
    var director: String
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let library = [
  Movie(name: "The Replacements", director: "Quentin Tarantino"),
  Song(name: "Hail to the Redskins", artist: "The Redskins Band"),
  Movie(name: "Any Given Sunday", director: "Martin Scorcese"),
  Song(name: "Hail Victory", artist: "Redskins Band"),
  Song(name: "Fight for ol' DC", artist: "TRB")
]
// The type of library is inferred ot be [MediaItem]

var movieCount = 0
var songCount = 0

for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Library contains \(movieCount) movies and \(songCount) songs")
// Prints "Library contains 2 movies and 3 songs"

for item in library {
    if let movie = item as? Movie {
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

/*
Movie: The Replacements, dir. Quentin Tarantino
Song: Hail to the Redskins, by The Redskins Band
Movie: Any Given Sunday, dir. Martin Scorcese
Song: Hail Victory, by Redskins Band
Song: Fight for ol' DC, by TRB
*/

var grabBag = [Any]()
grabBag.append(11)
grabBag.append(11.0)
grabBag.append(99)
grabBag.append(1.2345)
grabBag.append("httr")
grabBag.append(("tu","ple"))
grabBag.append(Movie(name: "Jerry Maguire", director: "David Lynch"))
grabBag.append({ (name: String) -> String in "Hello, \(name)" })
var optionalExampleNil: Int? = nil
var optionalExampleNonNil: Int? = 4
grabBag.append(optionalExampleNil as Any)
grabBag.append(optionalExampleNonNil as Any)

for item in grabBag {
    switch item {
    case 11 as Int:
        print("eleven as an Int")
    case 11 as Double:
        print("eleven as a Double")
    case let someInt as Int:
        print("an integer value of \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double value of \(someDouble)")
    case is Double:
        print("some other double value that I don't want to print")
    case let someString as String:
        print("a string value of \"\(someString)\"")
    case let (x, y) as (String, String):
        print("an (x, y) string-tuple with members \(x), \(y)")
    case let movie as Movie:
        print("a movie called \(movie.name), dir. \(movie.director)")
    case let stringConverter as (String) -> String:
        print(stringConverter("Big Game"))
    default:
        print("something else")
    }
}

/*
eleven as an Int
eleven as a Double
an integer value of 99
a positive double value of 1.2345
a string value of "httr"
an (x, y) string-tuple with members tu, ple
a movie called Jerry Maguire, dir. David Lynch
Hello, Big Game
*/

