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
    let gender: String
    let name: Name
    let location: Location
    // Otros datos relevantes del usuario
    
    struct Name: Codable {
        let title: String
        let first: String
        let last: String
    }
    
    struct Location: Codable {
        let street: Street
        let city: String
        let state: String
        let country: String
        let postcode: String
        
        struct Street: Codable {
            let number: Int
            let name: String
        }
    }
}
