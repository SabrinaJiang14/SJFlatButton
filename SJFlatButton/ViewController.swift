//
//  ViewController.swift
//  SJFlatButton
//
//  Created by Eileen on 2018/3/1.
//  Copyright © 2018年 Eileen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var customButton:SJFlatButton = SJFlatButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let frame = CGRect(x: 100, y: 100, width: 100, height: 80)
        customButton = SJFlatButton(frame: frame, andImagePosition: .top, title: "Test", imageName: "User")
        customButton.backgroundColor = UIColor.gray
        self.view.addSubview(customButton)
        
        customButton.badge = 5
        
        customButton.handleControlEvent(event: UIControlEvents.touchUpInside) {
            if var num = customButton.badge {
                num += 1
                customButton.badge = NSNumber(value: num) as? NSInteger
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

