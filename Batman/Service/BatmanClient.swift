import Foundation

public protocol BatmanClientProtocol {
    func fetchMovies(completion: @escaping (Result<SearchMovie, Error>) -> Void)
}

public class BatmanClient: BatmanClientProtocol {

    // MARK: Private Instance Property

    private let service = BatmanService()

    // MARK: Public methods

    public func fetchMovies(completion: @escaping (Result<SearchMovie, Error>) -> Void) {
        let moviesFetcher = service.moviesFetcher
        moviesFetcher.fetchMovies(completion: completion)
    }
}
