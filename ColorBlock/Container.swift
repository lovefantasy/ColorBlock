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
    let isBoard: Bool
    
    var isCompleted: Bool {
        if !isBoard { return false }
        
        for j in 0..<blocks.count {
            for i in 0..<blocks[0].count {
                if blocks[j][i] == nil {
                    print("board failed: empty blocks exist")
                    return false
                }
            }
        }
        
        if blocks.count > 1 {
            let hOffset = blocks[1][0]!.rgbValue - blocks[0][0]!.rgbValue
            for j in 0..<blocks.count-1 {
                for i in 0..<blocks[0].count {
                    if blocks[j+1][i]!.rgbValue - blocks[j][i]!.rgbValue != hOffset {
                        print("board failed: height check")
                        return false
                    }
                }
            }
        }
        
        if blocks[0].count > 1 {
            let wOffset = blocks[0][1]!.rgbValue - blocks[0][0]!.rgbValue
            for j in 0..<blocks.count {
                for i in 0..<blocks[0].count+1 {
                    if blocks[j][i+1]!.rgbValue - blocks[j][i]!.rgbValue != wOffset {
                        print("board failed: width check")
                        return false
                    }
                }
            }
        }
        
        return true
    }
    
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
                let acc: Int = 65535
                let rArray = randomChannelArray(count: width*height, accuracy: acc)
                let gArray = randomChannelArray(count: width*height, accuracy: acc)
                let bArray = randomChannelArray(count: width*height, accuracy: acc)
                
                var colorArray:[[Int]] = []
                for i in 0..<width*height { colorArray.append([rArray[i], gArray[i], bArray[i]]) }
                let randomed = colorArray.randomSorted()
                for j in 0..<height {
                    for i in 0..<width {
                        self.blocks[j][i] = Block(red: randomed[j*height+i][0], green: randomed[j*height+i][1], blue: randomed[j*height+i][2], accuracy: acc, isStatic: false)
                    }
                }
            }
        }
    }
    
    func addBlock(at: (w: Int, h: Int), block: Block) -> Bool {
        guard blocks[at.h][at.w] == nil else { return false }
        blocks[at.h][at.w] = block
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
    
    func removeBlock(at: (w: Int, h: Int)) -> Block? {
        guard let block = blocks[at.h][at.w] else { return nil }
        guard !block.isStatic else { return nil }
        blocks[at.h][at.w] = nil
        return block
    }
    
    private func randomChannelArray(count: Int, accuracy: Int) -> [Int] {
        var colors:[Int] = []
        let start = Int(arc4random_uniform(UInt32(accuracy)))
        let end = Int(arc4random_uniform(UInt32(accuracy)))
        
        for i in 0...count-1 {
            colors.append( (start*(count-i-1) + end*i) / (count-1) )
        }
        return colors
    }
}
