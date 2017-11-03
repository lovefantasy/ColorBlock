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
    
    init(code: UInt32, isStatic: Bool) {
        print("code:", code)
        self.color = UIColor(red: CGFloat(code/65536)/255, green: CGFloat((code%65535)/256)/255, blue: CGFloat(code%256)/255, alpha: 1.0)
        self.isStatic = isStatic
    }
    
    var encodedValue: UInt32 {
        if let channels = color.cgColor.components {
            return UInt32(channels[0]*255*256*256) + UInt32(channels[1]*255*256) + UInt32(channels[2]*255)
        } else {
            return UInt32.max
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
        return lhs.encodedValue == rhs.encodedValue
    }
}


