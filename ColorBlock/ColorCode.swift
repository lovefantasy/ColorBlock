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
    
    static func generateRandomColors(count: Int, difficulty: Int = 1) -> [ColorCode] {
        var result: [ColorCode] = []
        
        let i = arc4random_uniform(256)
        let j = arc4random_uniform(256 - i)
        let k = 256 - i - j
        let base = Int(max(i, j, k))
        let colorMolecular = Array.init([i, j, k]).randomSorted()
        let colorDenominator = UInt32(base * count * ( difficulty + 1 ))
        
        // would it overflow after float conversion?
        let redStart = CGFloat(arc4random_uniform(colorDenominator - colorMolecular[0] * UInt32(count))) / CGFloat(colorDenominator)
        let greenStart = CGFloat(arc4random_uniform(colorDenominator - colorMolecular[1] * UInt32(count))) / CGFloat(colorDenominator)
        let blueStart = CGFloat(arc4random_uniform(colorDenominator - colorMolecular[2] * UInt32(count))) / CGFloat(colorDenominator)
        
        let redOffset = CGFloat(colorMolecular[0]) / CGFloat(colorDenominator)
        let greenOffset = CGFloat(colorMolecular[1]) / CGFloat(colorDenominator)
        let blueOffset = CGFloat(colorMolecular[2]) / CGFloat(colorDenominator)
        
        for x in 0..<count {
            result.append(ColorCode(red: redStart + redOffset * CGFloat(x),
                                    green: greenStart + greenOffset * CGFloat(x),
                                    blue: blueStart + blueOffset * CGFloat(x)))
        }
        
        return result
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
