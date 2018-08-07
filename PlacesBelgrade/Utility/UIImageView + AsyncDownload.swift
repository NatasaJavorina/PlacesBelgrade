//
//  UIImageView + AsyncDownload.swift
//  PlacesBelgrade
//
//  Created by Natasa Javorina on 8/7/18.
//  Copyright © 2018 javorina. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func downloadImage(imageUrl: String, completion: @escaping ()->()) {
        if let url = URL(string:imageUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    DispatchQueue.main.async {
                        self.image = UIImage(data: data)
                        completion()
                    }
                }
            }
        }
    }
}
