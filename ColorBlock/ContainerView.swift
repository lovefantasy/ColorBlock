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
    var blockViews: [BlockView] = []
    var squareSize: CGFloat
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
                    blockViews.append(blockView)
                    self.addSubview(blockView)
                }
            }
        }
    }
    
    func addBlock(at: (w: Int, h: Int), block: Block) -> Bool {
        if container.addBlock(at: at, block: block) {
            let blockView = BlockView(frame: CGRect(
                x: CGFloat(at.w) * squareSize + blockPadding,
                y: CGFloat(at.h) * squareSize + blockPadding,
                width: squareSize - blockPadding * 2,
                height: squareSize - blockPadding * 2), block: block)
            blockViews.append(blockView)
            self.addSubview(blockView)
            return true
        } else {
            return false
        }
    }

    func moveBlock(from: (w: Int, h: Int), to: (w: Int, h: Int)) -> Bool {
        if container.moveBlock(from: from, to: to) {
            let movedBlockView = BlockView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), block: container.blocks[to.h][to.w]!)
            let index = blockViews.index(of: movedBlockView)!
            blockViews[index].center.x += CGFloat(to.w - from.w) * squareSize
            blockViews[index].center.y += CGFloat(to.h - from.h) * squareSize
            return true
        } else {
            return false
        }
    }

    func swapBlock(from: (w: Int, h: Int), with: (w: Int, h: Int)) -> Bool {
        if container.swapBlock(from: from, with: with) {
            let firstBlock = BlockView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), block: container.blocks[with.h][with.w]!)
            let secondBlock = BlockView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), block: container.blocks[from.h][from.w]!)
            let firstIndex = blockViews.index(of: firstBlock)!
            let secondIndex = blockViews.index(of: secondBlock)!
            let firstPoint = blockViews[firstIndex].center
            let secondPoint = blockViews[secondIndex].center
            blockViews[firstIndex].center = secondPoint
            blockViews[secondIndex].center = firstPoint
            return true
        } else {
            return false
        }
    }

    func removeBlock(at: (w: Int, h: Int)) -> Block? {
        if let removal = container.removeBlock(at: at) {
            let removalBlockView = BlockView(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0), block: removal)
            let index = blockViews.index(of: removalBlockView)!
            blockViews[index].removeFromSuperview()
            blockViews.remove(at: index)
            return removal
        } else {
            return nil
        }
    }
    
    func hitBlock(_ point: CGPoint) -> (w: Int, h: Int, block: Block?)? {
        let pointInView = CGPoint(x: point.x - self.frame.origin.x, y: point.y - self.frame.origin.y)
        
        for i in 0..<width {
            for j in 0..<height {
                if pointInView.x >= CGFloat(i) * squareSize &&
                    pointInView.x <= CGFloat(i+1) * squareSize &&
                    pointInView.y >= CGFloat(j) * squareSize &&
                    pointInView.y <= CGFloat(j+1) * squareSize {
                    return (i, j, container.blocks[j][i])
                }
            }
        }
        return nil
    }
}
