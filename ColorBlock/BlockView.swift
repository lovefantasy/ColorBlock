//
//  BlockButton.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/2.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit
import Foundation

class BlockView: UIView {
    let block: Block
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initialize ContainerView with NSCoder is not implemented")
    }
    
    override init(frame: CGRect) {
        fatalError("initialize ContainerView with CGRect is not implemented")
    }
    
    init(frame: CGRect, block: Block) {
        self.block = block
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.layer.backgroundColor = block.color.cgColor
        // print("initializing block with color:", block.description)
        self.layer.zPosition = 100
        self.setCornerRadiusRasterized(radius: frame.size.width / 10)
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        return block == (object as? BlockView)?.block
    }
}


