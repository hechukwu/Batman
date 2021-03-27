//
//  HomeViewModelTests.swift
//  BatmanTests
//
//  Created by Henry Chukwu on 27/03/2021.
//

import XCTest
@testable import Batman

class HomeViewModelTests: XCTestCase, HomeDelegate {

    private func createViewModel(_ apiClient: BatmanClientProtocol) -> HomeViewModel {
        return HomeViewModel(apiClient: apiClient)
    }

    var viewModel: HomeViewModel?

    override func setUpWithError() throws {
        viewModel = createViewModel(BatmanClientTest())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test_whenInitialized_storesInitParams() throws {
        XCTAssertNotNil(viewModel?.movies)
        XCTAssertNotNil(viewModel?.batmanClient)
    }

    func test_whenInitialized_fetchMovies_getsCalled() {
        viewModel?.fetchMovies(delegate: self)
        XCTAssert(viewModel?.movies.count == 3)

        if let movie = viewModel?.movies.first {
            XCTAssert(movie.Title == "Batman returns")
        }
    }

    func onGetMovies() {}
    func onError(_ message: String) {}
}
