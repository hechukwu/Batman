//
//  BatmanClientTest.swift
//  BatmanTests
//
//  Created by Henry Chukwu on 27/03/2021.
//

import Foundation
@testable import Batman

class BatmanClientTest: BatmanClientProtocol {

    func fetchMovies(completion: @escaping (Result<SearchMovie, Error>) -> Void) {
        completion(.success(TestData.searchMovie))
    }

    func fetchSingleMovie(_ imdbID: String, completion: @escaping (Result<Movie, Error>) -> Void) {
        completion(.success(TestData.movie))
    }
}
