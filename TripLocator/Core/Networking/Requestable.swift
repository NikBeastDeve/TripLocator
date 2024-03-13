import Foundation
import Moya

enum APIError: Error {
    case decodingError
    case requestError
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .decodingError:
            return NSLocalizedString("Server error happened", comment: "RequestError")
        case .requestError:
            return NSLocalizedString("Check you rinternet connection", comment: "RequestError")
        }
    }
}

protocol Requestable { }

extension Requestable {
    func request<T: Decodable>(decoder: JSONDecoder = JSONDecoder(),
                               provider: MoyaProvider<TripAPI>,
                               target: TripAPI,
                               completion: @escaping (Swift.Result<T, APIError>) -> ()) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    let results = try decoder.decode(T.self, from: response.data)
                    completion(.success(results))
                } catch {
                    completion(.failure(.decodingError))
                }
            case .failure(_):
                completion(.failure(.requestError))
            }
        }
    }
}
