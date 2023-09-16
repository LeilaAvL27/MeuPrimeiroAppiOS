//
//  UIImageView+Download.swift
//  MeuPrimeiroAppiOS
//
//  Created by Yago Marques on 01/08/23.
//

import UIKit

extension UIImageView {
    func download(path: String) {
        var imageUrl = URL(string: "https://image.tmdb.org/t/p/w500")!
        imageUrl.append(path: path)

        let task = URLSession.shared.dataTask(with: .init(url: imageUrl)) { data, response, error in
            if error != nil { return }

            guard let data else { return }

            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }

        task.resume()
    }
}
