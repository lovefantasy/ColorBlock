//
//  ViewController.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/1.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var containerViews: [ContainerView] = []
    var isPickingBlock: Bool = false
    var pickedBlockView: UIView?
    var originBlockView: (w: Int, h: Int, c: ContainerView)? = nil

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let board = Container(width: 1, height: 5, code: [], isBoard: true)
        let paint = Container(width: 3, height: 3, code: [], isBoard: false)
        let paintView = ContainerView(container: paint, square: 50, origin: CGPoint(x: 20, y: 50))
        let boardView = ContainerView(container: board, square: 50, origin: CGPoint(x: 200, y: 150))
        containerViews.append(paintView)
        containerViews.append(boardView)
        self.view.addSubview(paintView)
        self.view.addSubview(boardView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handlePan(recognizer: UIPanGestureRecognizer) {
        let point = recognizer.location(in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.began {
            for c in containerViews {
                if let grid = c.hitBlock(point) {
                    if let block = grid.block {
                        isPickingBlock = true
                        pickedBlockView = BlockView(frame: CGRect.init(x: point.x - c.squareSize / 2, y: point.y - c.squareSize / 2, width: c.squareSize, height: c.squareSize), block: block)
                        originBlockView = (w:grid.w, h:grid.h, c:c)
                        self.view.addSubview(pickedBlockView!)
                    }
                }
            }
        } else if recognizer.state == UIGestureRecognizerState.changed {
            if isPickingBlock {
                pickedBlockView!.center = point
            }
        } else if recognizer.state == UIGestureRecognizerState.ended {
            isPickingBlock = false
            if pickedBlockView != nil {
                pickedBlockView!.removeFromSuperview()
                pickedBlockView = nil
                
                for c in containerViews {
                    if let grid = c.hitBlock(point) {
                        // for debug
                        // print( String.init(format: "Drag complete, origin: %@,%d,%d, end: %@,%d,%d", originBlockView!.c, originBlockView!.w, originBlockView!.h, c, grid.w, grid.h) )
                        
                        if c.isEqual(originBlockView?.c) {
                            // 1. Hit successful in the same containerView
                            if grid.block != nil {
                                // 1-1. Hit a grid with a block
                                _ = c.swapBlock(from: (w:originBlockView!.w, h:originBlockView!.h), with: (w:grid.w, h:grid.h))
                            } else {
                                // 1-2. Hit a empty grid
                                _ = c.moveBlock(from: (w:originBlockView!.w, h:originBlockView!.h), to: (w:grid.w, h:grid.h))
                            }
                        } else {
                            // 2. Hit another containerView
                            if grid.block != nil {
                                // 2-1. Hit a grid with a block
                                if let removedBlock = c.removeBlock(at: (w: grid.w, h: grid.h)) {
                                    _ = c.addBlock(at: (w: grid.w, h: grid.h), block: originBlockView!.c.container.blocks[originBlockView!.h][originBlockView!.w]!)
                                    _ = originBlockView!.c.removeBlock(at: (w:originBlockView!.w, h:originBlockView!.h))
                                    _ = originBlockView!.c.addBlock(at: (w:originBlockView!.w, h:originBlockView!.h), block: removedBlock)
                                }
                            } else {
                                // 2-2. Hit a empty grid
                                if c.addBlock(at: (w: grid.w, h: grid.h), block: originBlockView!.c.container.blocks[originBlockView!.h][originBlockView!.w]!) {
                                    _ = originBlockView!.c.removeBlock(at: (w:originBlockView!.w, h:originBlockView!.h))
                                }
                            }
                        }
                    }
                    if c.container.isCompleted { print("completed!") }
                }
                originBlockView = nil
            } // if pickedBlockView
        }
    }
}

