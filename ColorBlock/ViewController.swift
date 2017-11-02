//
//  ViewController.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/1.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let board = Container(width: 1, height: 5, code: [], isBoard: true)
    let paint = Container(width: 3, height: 3, code: [], isBoard: false)

    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = UIColor.black
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let paintView = ContainerView(container: paint, square: 50, origin: CGPoint(x: 10, y: 10))
        let boardView = ContainerView(container: board, square: 50, origin: CGPoint(x: 150, y: 150))
        self.view.addSubview(paintView)
        self.view.addSubview(boardView)
        
//        for i in 1...5 {
//            let b = UIButton(frame: CGRect(x: 50, y: CGFloat(55*i), width: w, height: w))
//            b.backgroundColor = UIColor.clear
//            b.layer.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
//            b.layer.zPosition = 100
//            b.setCornerRadiusRasterized(radius: 5)
//            b.addTarget(self, action: #selector(dragView(sender:event:)), for: UIControlEvents.touchDragInside)
//            b.addTarget(self, action: #selector(releaseView(sender:event:)), for: UIControlEvents.touchUpInside)
//            self.view.addSubview(b)
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    @objc private func dragView(sender: AnyObject, event: UIEvent) {
//        guard let control = sender as? UIControl else { return }
//        guard let touch = event.allTouches?.first else { return }
//
//        var centerRectOfControl = control.center
//        centerRectOfControl.x += (touch.location(in: control).x - touch.previousLocation(in: control).x)
//        centerRectOfControl.y += (touch.location(in: control).y - touch.previousLocation(in: control).y)
//        control.center = centerRectOfControl
//    }
//
//    @objc private func releaseView(sender: AnyObject, event: UIEvent) {
//        guard let control = sender as? UIControl else { return }
//
//        let centerRectOfControl = control.center
//        if let center = c.hitTest(centerRectOfControl) {
//            control.center = center
//        }
//    }
}

