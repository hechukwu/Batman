import Foundation

protocol HomeDelegate {
    func onGetMovies()
    func onGetSingleMovie(_ movie: Movie?)
    func onError(_ message: String)
}

extension HomeDelegate {
    func onGetMovies() {}
    func onGetSingleMovie(_ movie: Movie?) {}
    func onError(_ message: String) {}
}

class HomeViewModel {

    // MARK: Public Instance Properties

    public let batmanClient: BatmanClientProtocol?
    public var movies: [Movie] = []
    public var filteredMoviesList: [Movie] = []
    public var favoriteMovies: [Movie] = []

    let coredata = CoreDataStack()

    public init(apiClient: BatmanClientProtocol) {
        self.batmanClient = apiClient
    }

    // MARK: Internal Instance Methods

    func fetchMovies(delegate: HomeDelegate) {

        batmanClient?.fetchMovies(completion: { result in
            switch result {
            case.success(let movies):
                self.movies = movies.Search
                delegate.onGetMovies()
            case .failure(let error): delegate.onError(error.localizedDescription)
            }
        })
    }

    func fetchMovie(_ imdbID: String, delegate: HomeDelegate) {

        batmanClient?.fetchSingleMovie(imdbID, completion: { result in
            switch result {
            case .success(let movie): delegate.onGetSingleMovie(movie)
            case .failure: break
            }
        })
    }

    func fetchMoviesFromCoredata() {
        if let controller = coredata.getMovieController() {
            let contents: [Movie] = controller.map {
                $0.toMovieModel()
            }
            self.favoriteMovies = contents
        }
    }

    func addToFavList(_ movie: Movie) {
        _ = coredata.upsertMovie(movie, save: true)
    }

    func removeFromFavList(_ movie: Movie) {
        coredata.deleteMovie(movie, save: true)
    }

}
