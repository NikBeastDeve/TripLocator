import Moya

protocol FindToursWorkerProtocol where Self: AnyObject {
    var provider: MoyaProvider<TripAPI> { get }
    func getDestinations(completion: @escaping (Swift.Result<DestinationResponse, APIError>) -> ())
}

final class FindToursWorker: FindToursWorkerProtocol, Requestable {
    var provider = MoyaProvider<TripAPI>(plugins: [])
    func getDestinations(completion: @escaping (Swift.Result<DestinationResponse, APIError>) -> Void) {
        request(provider: provider,
                target: .getDestinations,
                completion: completion)
    }
}
