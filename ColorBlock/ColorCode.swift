//
//  ColorCode.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/8.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import CoreGraphics
import Foundation

class ColorCode {
    let r: CGFloat
    let g: CGFloat
    let b: CGFloat
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.r = red
        self.g = green
        self.b = blue
    }
    
    static func + (lhs: ColorCode, rhs: ColorCode) -> ColorCode {
        return ColorCode(red: lhs.r + rhs.r, green: lhs.g + rhs.g, blue: lhs.b + rhs.b)
    }
    
    static func - (lhs: ColorCode, rhs: ColorCode) -> ColorCode {
        return ColorCode(red: lhs.r - rhs.r, green: lhs.g - rhs.g, blue: lhs.b - rhs.b)
    }
    
    static func == (lhs: ColorCode, rhs: ColorCode) -> Bool {
        return (lhs.r / rhs.r > 0.999 && lhs.g / rhs.g > 0.999 && lhs.b / rhs.b > 0.999)
    }
    
    static func != (lhs: ColorCode, rhs: ColorCode) -> Bool {
        return !(lhs == rhs)
    }
}
