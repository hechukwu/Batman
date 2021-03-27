public struct SearchMovie: Codable {
    var Search: [Movie]
}

struct Movie: Codable, Equatable {
    var Title, Year, Rated, Released, Runtime, Genre, Director, Writer, Actors, Language, Country, Awards, Poster, imdbID, `Type`: String?
}
