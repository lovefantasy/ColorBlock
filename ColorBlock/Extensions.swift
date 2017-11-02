//
//  Extensions.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/2.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit
import Foundation

// convinience uiview setting
extension UIView {
    func setCornerRadiusRasterized(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}

// random sort
extension Sequence {
    func randomSorted() -> [Element] {
        var result = Array(self)
        guard result.count > 1 else { return result }
        
        for (i, k) in zip(result.indices, stride(from: result.count, to: 1, by: -1)) {
            let newIndex = Int(arc4random_uniform(UInt32(k)))
            if newIndex == i { continue }
            result.swapAt(i, newIndex)
        }
        return result
    }
}
