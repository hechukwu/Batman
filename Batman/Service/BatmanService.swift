import Foundation

public typealias Identifier = String

public class BatmanService {

    // MARK: Private properties

    private static let apiKey = OMDB_API_KEY
    private static let baseURL = "http://www.omdbapi.com/"
    private var session: URLSession

    // MARK: Public properties

    public private(set) lazy var moviesFetcher: MovieFetcher = MovieFetcher(service: self)

    // MARK: class initializer

    public init() {
        self.session = URLSession.shared
    }

    internal func sendGetRequest(table: String,
                                 offset: Identifier?,
                                 completion: @escaping (Result<Data, Error>) -> Void) {
        guard
            var components = URLComponents(string: BatmanService.baseURL + table)
            else { return }

        if let offset = offset {
            components.queryItems = [URLQueryItem(name: "offset",
                                                  value: offset)]
        }

        components.percentEncodedQuery = components.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")

        guard
            let url = components.url
            else { return }

        var request = URLRequest(url: url)

        request.addValue("Bearer \(BatmanService.apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }

            guard let content = data else { return }
            DispatchQueue.main.async {
                completion(.success(content))
            }
        }

        task.resume()
    }
}
