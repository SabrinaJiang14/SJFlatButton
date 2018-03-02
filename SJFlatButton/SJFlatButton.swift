//
//  SJFlatButton.swift
//  SJFlatButton
//
//  Created by Eileen on 2018/3/1.
//  Copyright © 2018年 Eileen. All rights reserved.
//

import UIKit

private var closureKey: Void?
typealias ActionClosure = @convention(block) () -> ()

enum imagePosition {
    case top
    case buttom
    case left
    case right
}

class SJFlatButton: UIButton {
    
    fileprivate let padding:CGFloat = 5.0
    
    var badge:NSInteger?{
        willSet{
            print("\(String(describing: newValue))")
        }
        didSet{
            print("\(String(describing: badge))")
            if let num = badge {
                self.lblBadge?.text = "\(String(describing: num))"
            }
        }
    }
    
    fileprivate var position:imagePosition = .left
    fileprivate var lblBadge:UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        position = .left
        resetImageAndTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        position = .left
        resetImageAndTitle()
    }
    
    public init(frame: CGRect, andImagePosition:imagePosition, title:String?, imageName:String?) {
        super.init(frame: frame)
        
        position = andImagePosition
        
        if let titleStr = title {
            self.setTitle(titleStr, for: UIControlState.normal)
        }
        
        if let img = imageName {
            self.setImage(UIImage.init(named: img), for: UIControlState.normal)
        }
    }
    
    override func draw(_ rect: CGRect) {
        resetImageAndTitle()
        
        if let num = badge {
            lblBadge = UILabel.init(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
            lblBadge?.center = CGPoint(x: (self.imageView?.center.x)! / 2 + (padding * 2), y: 5)
            lblBadge?.backgroundColor = UIColor.red
            lblBadge?.layer.cornerRadius = 10
            lblBadge?.layer.masksToBounds = true
            lblBadge?.textColor = self.currentTitleColor
            lblBadge?.textAlignment = .center
            lblBadge?.font = UIFont.systemFont(ofSize: 14)
            lblBadge?.text = "\(num)"
            self.imageView?.addSubview(lblBadge!)
        }
    }
    
    
    override var isHighlighted: Bool{
        set {
            resetImageAndTitle()
            
            self.alpha = 1.0
            if (newValue == true) {
                self.alpha = 0.9
            }
        }
        get {
            return true
        }
    }
    
    func resetImageAndTitle(){
        self.imageView?.layer.masksToBounds = false
        
        switch position {
        case .top:
            if let iconImg = self.currentImage {
                self.imageView?.center = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height - iconImg.size.height) / 2)
                self.titleLabel?.numberOfLines = 0
                self.titleLabel?.center = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height + iconImg.size.height) / 2 + padding)
            }
        case .buttom:
            if let iconImg = self.currentImage {
                self.imageView?.center = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height + iconImg.size.height) / 2 + padding)
                self.titleLabel?.numberOfLines = 0
                self.titleLabel?.center = CGPoint(x: self.frame.size.width / 2, y: (self.frame.size.height - iconImg.size.height) / 2)
            }
            break
        case .left:
            self.titleLabel?.numberOfLines = 0
        case .right:
            if let iconImg = self.currentImage {
                self.imageView?.center = CGPoint(x: (self.frame.size.width + iconImg.size.height) / 2 + (padding * 2), y: self.frame.size.height / 2)
                self.titleLabel?.numberOfLines = 0
                self.titleLabel?.center = CGPoint(x: (self.frame.size.width - iconImg.size.height) / 2, y: self.frame.size.height / 2)
            }
            break
        }
    }
}

extension SJFlatButton {
    func handleControlEvent(event: UIControlEvents,closure: ActionClosure) {
        let dealObject: AnyObject = unsafeBitCast(closure, to: AnyObject.self)
        objc_setAssociatedObject(self, &closureKey, dealObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        self.addTarget(self, action: #selector(callActionClosure(btn:)), for: event)
    }
    
    @objc func callActionClosure(btn: UIButton) {
        let closureObject: AnyObject = objc_getAssociatedObject(self, &closureKey) as AnyObject
        let closure = unsafeBitCast(closureObject, to: ActionClosure.self)
        closure()
    }
}
