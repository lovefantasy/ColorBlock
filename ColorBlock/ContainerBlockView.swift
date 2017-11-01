//
//  ContainerBlockView.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/1.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit
import Foundation

class ContainerBlockView: UIView {
    required init?(coder aDecoder: NSCoder) {
        fatalError("init with NSCoder is not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setCornerRadiusRasterized(radius: self.frame.size.width / 10)
        self.backgroundColor = UIColor.clear
        self.layer.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 1.0).cgColor
    }
}
