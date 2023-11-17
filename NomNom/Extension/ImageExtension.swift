//
//  ImageExtension.swift
//  nomnom
//
//  Created by Life on 11/9/23.
//

import UIKit

extension UIImageView {
    func load(urlString: String) {
        if let url = URL(string: urlString) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
}
