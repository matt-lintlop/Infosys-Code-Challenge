//
//  ImageView+Download.swift
//  CodeChallenge
//
//  Created by Matt Lintlop on 9/23/18.
//  Copyright © 2018 Matt Lintlop. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(fromPath path: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: path) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
