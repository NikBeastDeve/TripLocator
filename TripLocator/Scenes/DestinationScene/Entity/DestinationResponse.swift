struct Destination: Codable {
    let id: Int
    let name: String
    let countryID: Int
    let countryName: String
    let pathIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryID = "country_id"
        case countryName = "country_name"
        case pathIDS = "path_ids"
    }
}

typealias DestinationResponse = [Destination]
