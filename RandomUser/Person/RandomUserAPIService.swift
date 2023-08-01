//
//  RandomUserAPIService.swift
//  RandomUser
//
//  Created by Arlen Peña on 01/08/23.
//

import Foundation


func RandomUserService(completion: @escaping (Result<User, Error>) -> Void) {
    guard let url = URL(string: "https://randomuser.me/api/") else {
        completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
        return
    }
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        guard let data = data else {
            completion(.failure(NSError(domain: "No data received", code: 0, userInfo: nil)))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let randomUserResponse = try decoder.decode(RandomUserResponse.self, from: data)
            if let user = randomUserResponse.results.first {
                completion(.success(user))
            } else {
                completion(.failure(NSError(domain: "No user found", code: 0, userInfo: nil)))
            }
        } catch {
            completion(.failure(error))
        }
    }.resume()
}
