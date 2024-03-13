import Foundation
import Moya

enum TripAPI {
    case getDestinations
    case createToursSearch(object: SearchQuery)
    case checkTours(id: String)
    case getTours(id: String)
}

extension TripAPI: TargetType {
    var baseURL: URL {
        switch self {
        default:
            guard let url = URL(string: "https://wwww.onlinetours.ru") else { fatalError("Unable to construct url") }
            return url
        }
    }

    var path: String {
        switch self {
        case .getDestinations:
            return "/api/v2/public/depart_cities"
        case .createToursSearch:
            return "/api/v2/public/searches"
        case let .checkTours(id):
            return "/api/v2/public/searches/\(id)"
        case let .getTours(id):
            return "/api/v2/public/searches/\(id)/offers"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getDestinations:
            return .get
        case .createToursSearch:
            return .post
        case .checkTours:
            return .get
        case .getTours:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .getDestinations:
            return .requestPlain
        case let .createToursSearch(query):
            return .requestJSONEncodable(query)
        case .checkTours:
            return .requestPlain
        case .getTours:
            return .requestParameters(parameters: ["limit": 50], encoding: URLEncoding.queryString)
        }
    }

    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization": "Token token=7f0185a09ec234cf0c2662a14d6e6fcf"]
        }
    }
    
    // This is sample return data that you can use to mock and test your services
    var sampleData: Data {
        return Data()
    }
}

