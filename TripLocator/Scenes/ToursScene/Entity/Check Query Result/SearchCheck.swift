import Foundation

// MARK: - SearchCheck
struct SearchCheck: Codable {
    let departCityID, countryID: Int?
    let countryName: String?
    let hotels: [String]?
    let regions: [Region]?
    let key: String?
    let progress: Int?
    let status: String?
    let adults, kids: Int?
    let kidsAges: [Int]?
    let durationFrom, durationTo: Int?
    let startFrom, startTo: String?
    let priceFrom, priceTo: Double?
    let visaRequired: Bool?
    let regionIDS: [Int]?
    let hotelIDS, mealTypeIDS, hotelCategoryIDS, operatorIDS: String?
    let tag: String?
    let hotelFeatureIDS: String?
    let ticketStrategy: String?
    let ignoreCache: Bool?
    let error: String?
    let host, createdAt, startedAt, finishedAt: String?

    enum CodingKeys: String, CodingKey {
        case departCityID = "depart_city_id"
        case countryID = "country_id"
        case countryName = "country_name"
        case hotels, regions, key, progress, status, adults, kids
        case kidsAges = "kids_ages"
        case durationFrom = "duration_from"
        case durationTo = "duration_to"
        case startFrom = "start_from"
        case startTo = "start_to"
        case priceFrom = "price_from"
        case priceTo = "price_to"
        case visaRequired = "visa_required"
        case regionIDS = "region_ids"
        case hotelIDS = "hotel_ids"
        case mealTypeIDS = "meal_type_ids"
        case hotelCategoryIDS = "hotel_category_ids"
        case operatorIDS = "operator_ids"
        case tag
        case hotelFeatureIDS = "hotel_feature_ids"
        case ticketStrategy = "ticket_strategy"
        case ignoreCache = "ignore_cache"
        case error, host
        case createdAt = "created_at"
        case startedAt = "started_at"
        case finishedAt = "finished_at"
    }
}

// MARK: - Region
struct Region: Codable {
    let id: Int?
    let name: String?
    let countryID: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case countryID = "country_id"
    }
}
