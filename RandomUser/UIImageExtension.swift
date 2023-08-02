//
//  UIImageExtension.swift
//  RandomUser
//
//  Created by Arlen Peña on 01/08/23.
//

import UIKit

extension UIImage {
    static func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let session = URLSession.shared
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error al descargar la imagen: \(error.localizedDescription)")
                completion(nil)
                return
            }

            if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                print("Los datos de la imagen no son válidos.")
                completion(nil)
            }
        }

        task.resume()
    }
}
