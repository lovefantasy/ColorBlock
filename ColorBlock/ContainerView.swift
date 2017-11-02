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
    let container: Container
    private var squareSize: CGFloat
    private var width: Int
    private var height: Int
    var blockSize: CGFloat { return squareSize - blockPadding * 2 }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("initialize ContainerView with NSCoder is not implemented")
    }
    
    override init(frame: CGRect) {
        fatalError("initialize ContainerView with CGRect is not implemented")
    }
    
    // initialize with origin and fixed block size
    init(container: Container, square: CGFloat, origin: CGPoint = CGPoint(x: 0, y: 0)) {   
        self.squareSize = square
        self.width = container.blocks[0].count
        self.height = container.blocks.count
        self.container = container
        
        // view construction
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: square * CGFloat(width), height: square * CGFloat(height)))
        self.backgroundColor = UIColor.black
        setupBlockBackground()
        setupBlocks()
    }
    
    // initialize with fixed frame and dynamic block size
    init(container: Container, frame: CGRect) {
        self.width = container.blocks[0].count
        self.height = container.blocks.count
        self.container = container
        let estimatedSizeW = (frame.size.width - blockPadding * CGFloat(width + 1)) / CGFloat(width)
        let estimatedSizeH = (frame.size.height - blockPadding * CGFloat(height + 1)) / CGFloat(height)
        self.squareSize = min(estimatedSizeW, estimatedSizeH)
        
        // FIXME: this would possibly leave empty spaces, padding on H/V should be different
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        setupBlockBackground()
        setupBlocks()
    }
    
    func setupBlockBackground() {
        for i in 0..<width {
            for j in 0..<height {
                let bgView = ContainerBlockView(frame: CGRect(
                    x: CGFloat(i) * squareSize + blockPadding,
                    y: CGFloat(j) * squareSize + blockPadding,
                    width: squareSize - blockPadding * 2,
                    height: squareSize - blockPadding * 2))
                self.addSubview(bgView)
            }
        }
    }
    
    func setupBlocks() {
        for i in 0..<width {
            for j in 0..<height {
                if let block = container.blocks[j][i] {
                    let blockView = BlockView(frame: CGRect(
                        x: CGFloat(i) * squareSize + blockPadding,
                        y: CGFloat(j) * squareSize + blockPadding,
                        width: squareSize - blockPadding * 2,
                        height: squareSize - blockPadding * 2), block: block)
                    self.addSubview(blockView)
                }
            }
        }
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
