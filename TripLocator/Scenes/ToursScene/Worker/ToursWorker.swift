import Moya

protocol ToursWorkerProtocol where Self: AnyObject {
    var provider: MoyaProvider<TripAPI> { get }
    func startSearch(query: SearchQuery,
                     completion: @escaping (Swift.Result<SearchQueryResponse, APIError>) -> Void)
    func checkSearch(id: String,
                     completion: @escaping (Swift.Result<SearchCheck, APIError>) -> Void)
    func fetchSearchResults(id: String,
                            completion: @escaping (Swift.Result<ToursResult, APIError>) -> Void)
}

final class ToursWorker: ToursWorkerProtocol, Requestable {
    var provider = MoyaProvider<TripAPI>(plugins: [])
    func startSearch(query: SearchQuery,
                     completion: @escaping (Swift.Result<SearchQueryResponse, APIError>) -> Void) {
        request(provider: provider,
                target: .createToursSearch(object: query),
                completion: completion)
    }
    
    func checkSearch(id: String,
                     completion: @escaping (Swift.Result<SearchCheck, APIError>) -> Void) {
        request(provider: provider,
                target: .checkTours(id: id),
                completion: completion)
    }
    
    func fetchSearchResults(id: String,
                            completion: @escaping (Swift.Result<ToursResult, APIError>) -> Void) {
        request(provider: provider,
                target: .getTours(id: id),
                completion: completion)
    }
}
