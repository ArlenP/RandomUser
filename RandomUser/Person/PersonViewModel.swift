//
//  PersonViewModel.swift
//  RandomUser
//
//  Created by Arlen Peña on 01/08/23.
//
import Foundation

class PersonViewModel {
    
    func fetchRandomUser(completion: @escaping (Result<User, Error>) -> Void) {
        RandomUserService { result in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
}
