import Foundation

protocol HomeDelegate {
    func onGetMovies()
    func onError(message: String)
}

class HomeViewModel {

    // MARK: Public Instance Properties

    public let batmanClient: BatmanClientProtocol?
    public var movies: [Movie] = []
    public var filteredMoviesList: [Movie] = []

    public init(apiClient: BatmanClientProtocol) {
        self.batmanClient = apiClient
    }

    // MARK: Internal Instance Methods

    func fetchMovies(delegate: HomeDelegate) {

        batmanClient?.fetchMovies(completion: { result in
            switch result {
            case.success(let movies):
                self.movies = movies
                delegate.onGetMovies()
            case .failure: break
            }
        })
    }

}
