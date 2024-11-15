//
//  VendorModel.swift
//  delivery
//
//  Created by apple on 14/11/24.
//

import Foundation
// MARK: - VendorResponse
struct VendorResponse: Codable {
    let success: Bool
    let status: Int
    let message, messageCode: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case success, status, message
        case messageCode = "message_code"
        case data
    }
}

// MARK: - DataClass
struct DataClass: Codable,Identifiable {
    let id: String
    let name: Name
    let description, supportSampling, supportRental, hasTrayService: String
    let minOrderAmount: String
    let logo, banner: String
    let cartCount, totalAmount, hasAddedTray: String
    let categories: [Category]
    let sampleboxes: [Samplebox]
    let orderID: String
    let trayList, sampleboxList: [JSONAny]
    let selectedDate, selectedTimeslot: String
    let allTrayList: [JSONAny]
    let isTrayListing, hideTimeslot: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case supportSampling = "support_sampling"
        case supportRental = "support_rental"
        case hasTrayService = "has_tray_service"
        case minOrderAmount = "min_order_amount"
        case logo, banner
        case cartCount = "cart_count"
        case totalAmount = "total_amount"
        case hasAddedTray = "has_added_tray"
        case categories, sampleboxes
        case orderID = "order_id"
        case trayList = "tray_list"
        case sampleboxList = "samplebox_list"
        case selectedDate = "selected_date"
        case selectedTimeslot = "selected_timeslot"
        case allTrayList = "all_tray_list"
        case isTrayListing = "is_tray_listing"
        case hideTimeslot = "hide_timeslot"
    }
}

// MARK: - Category
struct Category: Codable, Identifiable  {
    let id: String?
    let name: String
    let linkCategoryID: String?
    let productServices: [ProductService]

    enum CodingKeys: String, CodingKey {
        case id, name
        case linkCategoryID = "link_category_id"
        case productServices = "product_services"
    }
}

// MARK: - ProductService
struct ProductService: Codable,Identifiable {
    let id, name, description, isShowDisclaimer: String
    let disclaimerMessage, regularPrice, finalPrice, regularPricePerKg: String
    let finalPricePerKg, disableQtyStepper, isUnavailable, quantity: String
    let availableQuantity: String
    let unit: Unit
    let weight: String
    let sessionDuration: SessionDuration
    let serviceDuration, timeSlotQuantity, newArrivalStartTime, newArrivalEndTime: String
    let vendorID: String
    let vendorName: Name
    let type: TypeEnum
    let enableGiftOption: String
    let productType: ProductType
    let isAddonsAvailable, isBestSeller, isAllowCustomerComment, isAllowedSampling: String
    let isAllowedRental, supportsTray: String
    let sampleType: SampleType
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, name, description
        case isShowDisclaimer = "is_show_disclaimer"
        case disclaimerMessage = "disclaimer_message"
        case regularPrice = "regular_price"
        case finalPrice = "final_price"
        case regularPricePerKg = "regular_price_per_kg"
        case finalPricePerKg = "final_price_per_kg"
        case disableQtyStepper = "disable_qty_stepper"
        case isUnavailable = "is_unavailable"
        case quantity
        case availableQuantity = "available_quantity"
        case unit, weight
        case sessionDuration = "session_duration"
        case serviceDuration = "service_duration"
        case timeSlotQuantity = "time_slot_quantity"
        case newArrivalStartTime = "new_arrival_start_time"
        case newArrivalEndTime = "new_arrival_end_time"
        case vendorID = "vendor_id"
        case vendorName = "vendor_name"
        case type
        case enableGiftOption = "enable_gift_option"
        case productType = "product_type"
        case isAddonsAvailable = "is_addons_available"
        case isBestSeller = "is_best_seller"
        case isAllowCustomerComment = "is_allow_customer_comment"
        case isAllowedSampling = "is_allowed_sampling"
        case isAllowedRental = "is_allowed_rental"
        case supportsTray = "supports_tray"
        case sampleType = "sample_type"
        case image
    }
}

enum ProductType: String, Codable {
    case weight = "weight"
}

enum SampleType: String, Codable {
    case empty = ""
    case pieces = "pieces"
}

enum SessionDuration: String, Codable {
    case s = "S"
}

enum TypeEnum: String, Codable {
    case p = "P"
}

enum Unit: String, Codable {
    case kg = "KG"
}

enum Name: String, Codable {
    case anya = "Anya"
}

// MARK: - Samplebox
struct Samplebox: Codable {
    let id, name, pieces, price: String
    let image: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}

