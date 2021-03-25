import Foundation

public class MovieFetcher {

    // MARK: properties

    private var offset: Identifier?

    private weak var service: BatmanService?

    // class initializer

    internal init(service: BatmanService) {
        self.offset = nil
        self.service = service
    }

    func fetchMovies(completion: @escaping (Result<SearchMovie, Error>) -> Void) {

        let urlSuffix = "?s=Batman&apikey=\(OMDB_API_KEY)"

        service?.sendGetRequest(table: urlSuffix,
                                offset: offset) { [weak self] result in
            self?.deserialize(result: result, completion: completion)
        }
    }

    // A helper function to parse the data

    private func deserialize<T: Decodable>(result: Result<Data, Error>, completion: ((Result<T, Error>) -> Void)? = nil) {

        switch result {
        case .success(let data):
            do {

                let rawDict = try JSONDecoder().decode(T.self , from: data)

                completion?(.success(rawDict))

            } catch {
                completion?(.failure(AppError.unDecodableResponse))
            }
        case .failure(let error): completion?(.failure(error))
        }
    }
}
