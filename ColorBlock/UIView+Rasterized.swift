//
//  UIView+Rasterized.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/1.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    func setCornerRadiusRasterized(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
