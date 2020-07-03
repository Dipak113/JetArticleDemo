//
//  ImageViewExtension.swift
//  JetArticleDemo
//
//  Created by Dipak Dhondge on 03/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {

    func loadImageFromServer(url: String) {
        if let imageUrl = URL(string: url) {
            DispatchQueue.global().async { [weak self] in
                
                if let imageFromCache = imageCache.object(forKey: imageUrl as AnyObject) as? UIImage {
                    DispatchQueue.main.async {
                        self?.image = imageFromCache
                    }
                    return
                }
                
                if let data = try? Data(contentsOf: imageUrl) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image = image
                            imageCache.setObject(image, forKey: imageUrl as AnyObject)
                        }
                    }
                }
            }

        } else {
            self.image = UIImage(named: Constants.ImageNames.defaultImage)
        }
    }
}
