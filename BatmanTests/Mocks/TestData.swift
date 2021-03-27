//
//  TestData.swift
//  BatmanTests
//
//  Created by Henry Chukwu on 27/03/2021.
//

import XCTest
@testable import Batman

class TestData {

    static var searchMovie: SearchMovie {
        return SearchMovie(Search: movieArray)
    }

    static var movie: Movie {

        return Movie(Title: "Batman returns",
                     Year: "1992",
                     Rated: nil,
                     Released: nil,
                     Runtime: nil,
                     Genre: nil,
                     Director: nil,
                     Writer: nil,
                     Actors: nil,
                     Language: nil,
                     Country: nil,
                     Plot: nil,
                     Awards: nil,
                     Poster: nil,
                     imdbID: nil,
                     Type: nil)
    }

    static var movieArray: [Movie] {
        var movieArr = [Movie]()
        for _ in 1...3 {
            movieArr.append(movie)
        }
        return movieArr
    }
}
