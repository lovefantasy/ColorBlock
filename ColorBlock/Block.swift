//
//  Block.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/2.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit
import Foundation

class Block: CustomStringConvertible, Equatable {
    let color: UIColor
    let isStatic: Bool
    
    init(color: UIColor, isStatic: Bool) {
        self.color = color
        self.isStatic = isStatic
    }
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat, isStatic: Bool) {
        self.color = UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        self.isStatic = isStatic
    }
    
    init(red: Int, green: Int, blue: Int, accuracy: Int, isStatic: Bool) {
        self.color = UIColor(red: CGFloat(red)/CGFloat(accuracy), green: CGFloat(green)/CGFloat(accuracy), blue: CGFloat(blue)/CGFloat(accuracy), alpha: 1.0)
        self.isStatic = isStatic
    }
    
    init(code: UInt32, isStatic: Bool) {
        self.color = UIColor(red: CGFloat(code/65536)/255, green: CGFloat((code%65535)/256)/255, blue: CGFloat(code%256)/255, alpha: 1.0)
        self.isStatic = isStatic
    }
    
    var rgbValue: ColorCode {
        if let channels = color.cgColor.components {
            return ColorCode(red: channels[0], green: channels[1], blue: channels[2])
        } else {
            return ColorCode(red: -1, green: -1, blue: -1)
        }
    }
    
    // for debug
    var description: String {
        if let channels = color.cgColor.components {
            return String.init(format: "#%02X%02X%02X", Int(channels[0]*255), Int(channels[1]*255), Int(channels[2]*255))
        } else {
            return ""
        }
    }
    
    // protocol - Equatable
    static func == (lhs: Block, rhs: Block) -> Bool {
        if let lhsChannel = lhs.color.cgColor.components, let rhsChannel = rhs.color.cgColor.components {
            return (lhsChannel[0] == rhsChannel[0] && lhsChannel[1] == rhsChannel[1] && lhsChannel[2] == rhsChannel[2])
        }
        return false
    }
}


