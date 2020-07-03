//
//  ViewExtension.swift
//  JetArticleDemo
//
//  Created by Dipak Dhondge on 03/07/20.
//  Copyright © 2020 Dipak Dhondge. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func showBlurLoader() {
        DispatchQueue.main.async {
            let blurLoader = BlurLoader(frame: self.frame)
            self.addSubview(blurLoader)
        }
    }

    func removeBluerLoader() {
        DispatchQueue.main.async {
            if let blurLoader = self.subviews.first(where: { $0 is BlurLoader }) {
                blurLoader.removeFromSuperview()
            }
        }
    }
}
