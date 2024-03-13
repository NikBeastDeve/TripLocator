// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let toursResult = try? JSONDecoder().decode(ToursResult.self, from: jsonData)

import Foundation

// MARK: - ToursResult
struct ToursResult: Codable {
    let offers: [Offer]?
    let stats: Stats?
}

// MARK: - Offer
struct Offer: Codable {
    let id, title: String?
    let includeTickets: Bool?
    let provider: String?
    let hotelID, departCityID, regionID, countryID: Int?
    let adults, kids: Int?
    let startDate: String?
    let duration, hotelDuration, tourDuration: Int?
    let originalName: String?
    let availability: Availability?
    let originalURL: String?
    let checkout: Checkout?
    let actualizationAvailable, costChanged: Bool?
    let getTourLinkPath: String?
    let promo: Bool?
    let transport: String?
    let services: Services?
    let isAvailableForBooking: Bool?
    let operatorID: Int?
    let offerOperator: OfferOperator?
    let roomType: RoomType?
    let mealTypeID: Int?
    let mealType: MealType?
    let economic, business: Business?
    let price: Price?
    let originalPrice: OriginalPrice?
    let operatorName, operatorCompactName: String?
    let minAges, maxAges: Int?

    enum CodingKeys: String, CodingKey {
        case id, title
        case includeTickets = "include_tickets"
        case provider
        case hotelID = "hotel_id"
        case departCityID = "depart_city_id"
        case regionID = "region_id"
        case countryID = "country_id"
        case adults, kids
        case startDate = "start_date"
        case duration
        case hotelDuration = "hotel_duration"
        case tourDuration = "tour_duration"
        case originalName = "original_name"
        case availability
        case originalURL = "original_url"
        case checkout
        case actualizationAvailable = "actualization_available"
        case costChanged = "cost_changed"
        case getTourLinkPath = "get_tour_link_path"
        case promo, transport, services
        case isAvailableForBooking = "is_available_for_booking"
        case operatorID = "operator_id"
        case offerOperator = "operator"
        case roomType = "room_type"
        case mealTypeID = "meal_type_id"
        case mealType = "meal_type"
        case economic, business, price
        case originalPrice = "original_price"
        case operatorName = "operator_name"
        case operatorCompactName = "operator_compact_name"
        case minAges = "min_ages"
        case maxAges = "max_ages"
    }
}

enum Availability: String, Codable {
    case request = "request"
}

// MARK: - Business
struct Business: Codable {
    let departure, returning: Departure?
}

// MARK: - Departure
struct Departure: Codable {
    let availability: Availability?
    let title: Title?
}

enum Title: String, Codable {
    case поЗапросу = "По запросу"
}

// MARK: - Checkout
struct Checkout: Codable {
    let requiredFields: [String]?

    enum CodingKeys: String, CodingKey {
        case requiredFields = "required_fields"
    }
}

// MARK: - MealType
struct MealType: Codable {
    let originalName, name: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case name, id
    }
}

// MARK: - OfferOperator
struct OfferOperator: Codable {
    let id: Int?
    let name: String?
}

// MARK: - OriginalPrice
struct OriginalPrice: Codable {
    let price: Int?
    let currency: String?
}

// MARK: - Price
struct Price: Codable {
    let total, partner, subtotal, original: Int?
    let oilTax, insuranceTax, markup: Int?
    let lowFee: Bool?

    enum CodingKeys: String, CodingKey {
        case total, partner, subtotal, original
        case oilTax = "oil_tax"
        case insuranceTax = "insurance_tax"
        case markup
        case lowFee = "low_fee"
    }
}

// MARK: - RoomType
struct RoomType: Codable {
    let fullName, name: String?
    let id: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case name, id
    }
}

// MARK: - Services
struct Services: Codable {
    let insurance, transfer: String?
}

// MARK: - Stats
struct Stats: Codable {
    let status: String?
    let count: Int?
    let minPrice: MinPrice?
    let operators: [OperatorElement]?

    enum CodingKeys: String, CodingKey {
        case status, count
        case minPrice = "min_price"
        case operators
    }
}

// MARK: - MinPrice
struct MinPrice: Codable {
    let total, subtotal, original: Int?
}

// MARK: - OperatorElement
struct OperatorElement: Codable {
    let id: Int?
    let name: String?
    let count: Int?
    let bestValue: MinPrice?

    enum CodingKeys: String, CodingKey {
        case id, name, count
        case bestValue = "best_value"
    }
}
