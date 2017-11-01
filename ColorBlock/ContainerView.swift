//
//  ContainerView.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/1.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit
import Foundation

class ContainerView: UIView {
    let blockPadding: CGFloat = 5
    private var squareSize: CGFloat
    private var width: Int
    private var height: Int
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initialize ContainerView with NSCoder is not implemented")
    }
    
    override init(frame: CGRect) {
        fatalError("initialize ContainerView with CGRect is not implemented")
    }
    
    init(width: Int, height: Int, square: CGFloat, origin: CGPoint = CGPoint(x: 0, y: 0)) {
        guard width > 0 else { fatalError("initialize ContainerView with invalid width") }
        guard height > 0 else { fatalError("initialize ContainerView with invalid width") }
        
        self.squareSize = square
        self.width = width
        self.height = height
        
        // view construction
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: square * CGFloat(width), height: square * CGFloat(height)))
        self.backgroundColor = UIColor.black
        
        // subview: ContainerBlock(s)
        for i in 0..<width {
            for j in 0..<height {
                let block = ContainerBlockView(frame: CGRect(
                    x: CGFloat(i) * square + blockPadding,
                    y: CGFloat(j) * square + blockPadding,
                    width: square - blockPadding * 2,
                    height: square - blockPadding * 2))
                self.addSubview(block)
            }
        }
    }
    
    var blockSize: CGFloat {
        return squareSize - blockPadding * 2
    }
    
    func hitTest(_ point: CGPoint) -> CGPoint? {
        let pointInView = CGPoint(x: point.x - self.frame.origin.x, y: point.y - self.frame.origin.y)
        
        for i in 0..<width {
            for j in 0..<height {
                if pointInView.x >= CGFloat(i) * squareSize + blockPadding &&
                    pointInView.x <= CGFloat(i+1) * squareSize - blockPadding &&
                    pointInView.y >= CGFloat(j) * squareSize + blockPadding &&
                    pointInView.y <= CGFloat(j+1) * squareSize - blockPadding {
                    return CGPoint(x: self.frame.origin.x + (CGFloat(i)+0.5) * squareSize,
                                   y: self.frame.origin.y + (CGFloat(j)+0.5) * squareSize)
                }
            }
        }
        return nil
    }
}
