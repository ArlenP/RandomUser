//
//  ViewController.swift
//  RandomUser
//
//  Created by Arlen Peña on 01/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = PersonViewModel()

       override func viewDidLoad() {
           super.viewDidLoad()
           
           viewModel.fetchRandomUser { result in
               switch result {
               case .success(let user):
                   print("User name: \(user.name.first) \(user.name.last)")
               case .failure(let error):
                   print("Error fetching user: \(error)")
               }
           }
       }
}

