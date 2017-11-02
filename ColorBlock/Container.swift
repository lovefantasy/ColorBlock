//
//  Container.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/2.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import Foundation

class Container {
    var blocks: Array<Array<Block?>>
    var isCompleted: Bool = false
    let isBoard: Bool
    
    init(width: Int, height: Int, code: [UInt32], isBoard: Bool) {
        guard width > 0 else { fatalError("initialize container with invalid width") }
        guard height > 0 else { fatalError("initialize container with invalid width") }
        guard width * height >= code.count else { fatalError("unmatched width/height and data source.") }
        guard width * height >= 3 else { fatalError("too small container.") }
        
        self.isBoard = isBoard
        self.blocks = Array(repeatElement(Array(repeatElement(nil, count: width)), count: height))
        
        // if it's not a board, put the colors randomly
        if !isBoard {
            if code.count > 0 {
                let randomed = code.randomSorted()
                for j in 0..<height {
                    for i in 0..<width {
                        guard j*height+i < code.count else { continue }
                        self.blocks[j][i] = Block(code: randomed[j*height+i], isStatic: false)
                    }
                }
            } else { // if code is null, randomly fill with valid blocks
                var colors:[UInt32] = []
                let startColor = arc4random_uniform(255*256*256)
                let endColor = arc4random_uniform(255*256*256)
                colors.append(startColor)
                colors.append(endColor)
                
                for i in 1..<(width*height-1) {
                    let color = startColor * UInt32(i) / UInt32(width*height-1)
                              + endColor * UInt32(width*height-i-1) / UInt32(width*height-1)
                    colors.append(color)
                }
                let randomed = colors.randomSorted()
                for j in 0..<height {
                    for i in 0..<width {
                        self.blocks[j][i] = Block(code: randomed[j*height+i], isStatic: false)
                    }
                }
            }
        }
    }
    
    func addBlock(index: (w: Int, h: Int), block: Block) -> Bool {
        guard blocks[index.h][index.w] == nil else { return false }
        blocks[index.h][index.w] = block
        return true
    }
    
    func moveBlock(from: (w: Int, h: Int), to: (w: Int, h: Int)) -> Bool {
        guard let block = blocks[from.h][from.w] else { return false }
        guard !block.isStatic else { return false }
        guard blocks[to.h][to.w] == nil else { return false }
        blocks[to.h][to.w] = block
        blocks[from.h][from.w] = nil
        return true
    }
    
    func swapBlock(from: (w: Int, h: Int), with: (w: Int, h: Int)) -> Bool {
        guard let fromBlock = blocks[from.h][from.w], let withBlock = blocks[with.h][with.w] else { return false }
        guard !fromBlock.isStatic && !withBlock.isStatic else { return false }
        blocks[from.h][from.w] = withBlock
        blocks[with.h][with.w] = fromBlock
        return true
    }
    
    func removeBlock(index: (w: Int, h: Int)) -> Block? {
        guard let block = blocks[index.h][index.w] else { return nil }
        guard !block.isStatic else { return nil }
        blocks[index.h][index.w] = nil
        return block
    }
}
