//
//  PersonModel.swift
//  RandomUser
//
//  Created by Arlen Peña on 01/08/23.
//

import Foundation

struct RandomUserResponse: Codable {
    let results: [User]
}

struct User: Codable {
    let gender: String?
    let name: Name
    let location: Location?
    
    struct Name: Codable {
        let title: String?
        let first: String?
        let last: String?
    }
    
    struct Location: Codable {
        let street: Street?
        let city: String?
        let state: String?
        let country: String?
        let postcode: Postcode?
        
        struct Street: Codable {
            let number: Int?
            let name: String?
        }
        
    }
}

struct Postcode: Codable {
    private enum CodingKeys: CodingKey {
        case intValue, stringValue
    }
    
    private var intValue: Int?
    private var stringValue: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let intValue = try? container.decode(Int.self) {
            self.intValue = intValue
        } else if let stringValue = try? container.decode(String.self) {
            self.stringValue = stringValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        if let intValue = intValue {
            try container.encode(intValue)
        } else if let stringValue = stringValue {
            try container.encode(stringValue)
        }
    }
}

extension Postcode: ExpressibleByIntegerLiteral, ExpressibleByStringLiteral {
    init(integerLiteral value: Int) {
        self.intValue = value
    }
    
    init(stringLiteral value: String) {
        self.stringValue = value
    }
}

extension Postcode: Equatable {
    static func ==(lhs: Postcode, rhs: Postcode) -> Bool {
        if let intValue1 = lhs.intValue, let intValue2 = rhs.intValue {
            return intValue1 == intValue2
        }
        if let stringValue1 = lhs.stringValue, let stringValue2 = rhs.stringValue {
            return stringValue1 == stringValue2
        }
        return false
    }
}
