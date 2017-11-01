//
//  ViewController.swift
//  ColorBlock
//
//  Created by 張智光 on 2017/11/1.
//  Copyright © 2017年 HardMode. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let b = UIButton(frame: CGRect(x: 50, y: 50, width: 50, height: 50))
        b.backgroundColor = UIColor.clear
        b.layer.backgroundColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        b.setCornerRadiusRasterized(radius: 5)
        b.addTarget(self, action: #selector(dragView(sender:event:)), for: UIControlEvents.touchDragInside)
        b.addTarget(self, action: #selector(dragView(sender:event:)), for: UIControlEvents.touchDragOutside)
        self.view.addSubview(b)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc private func dragView(sender: AnyObject, event: UIEvent) {
        guard let control = sender as? UIControl else { return }
        guard let touch = event.allTouches?.first else { return }

        var centerRectOfControl = control.center
        centerRectOfControl.x += (touch.location(in: control).x - touch.previousLocation(in: control).x)
        centerRectOfControl.y += (touch.location(in: control).y - touch.previousLocation(in: control).y)
        control.center = centerRectOfControl
    }
}

