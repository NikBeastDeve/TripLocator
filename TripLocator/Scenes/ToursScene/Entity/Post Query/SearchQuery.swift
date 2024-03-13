import Foundation

struct SearchQuery: Codable {
    let search: Search
}

struct Search: Codable {
    let departCityID: Int
    let regionIDS: [Int]
    let startFrom, startTo: String
    let durationFrom, durationTo, adults: Int

    enum CodingKeys: String, CodingKey {
        case departCityID = "depart_city_id"
        case regionIDS = "region_ids"
        case startFrom = "start_from"
        case startTo = "start_to"
        case durationFrom = "duration_from"
        case durationTo = "duration_to"
        case adults
    }
}
