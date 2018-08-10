//
//  SlideMenu.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/9.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

class SlideMenu: UIView {

    
    private var keyWindow: UIWindow?
    private var blurView: UIVisualEffectView!
    private var helperSideView: UIView!
    private var helperCenterView: UIView!
    
    private var diff: CGFloat = 0.0
    private var triggered: Bool = false
    private var displayLink: CADisplayLink?
    private var animationCount: Int = 0

    private let menuBlankWidth: CGFloat = 50
    private let menuColor = #colorLiteral(red: 0.7411764706, green: 0.8941176471, blue: 0.6588235294, alpha: 1)
    
    
    override init(frame: CGRect) {
        if let kWindow = UIApplication.shared.keyWindow {
            keyWindow = kWindow
            let f = CGRect(x: -kWindow.frame.width / 2 - menuBlankWidth, y: 0, width: kWindow.frame.width / 2 + menuBlankWidth, height: kWindow.frame.height)
            super.init(frame: f)
        } else {
            super.init(frame: .zero)
        }
        setupViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: frame.width - menuBlankWidth, y: 0))
        path.addQuadCurve(to: CGPoint(x: frame.width - menuBlankWidth, y: frame.height), controlPoint: CGPoint(x: frame.width - menuBlankWidth + diff, y: frame.height / 2))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(path.cgPath)
        menuColor.set()
        context?.fillPath()
        
    }
    
    open func trigger() {
        if !triggered {
            if let keyWindow = keyWindow {
                keyWindow.insertSubview(blurView, belowSubview: self)
                UIView.animate(withDuration: 0.3) {
                    self.frame = self.bounds
                }
                
                beforeAnimation()
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.9, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                    self.helperSideView.center = CGPoint(x: keyWindow.center.x, y: self.helperCenterView.frame.height / 2)
                }) { (_) in
                    self.finishAnimation()
                }
                
                UIView.animate(withDuration: 0.3) {
                    self.blurView.alpha = 1
                }
                beforeAnimation()
                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                    self.helperCenterView.center = keyWindow.center
                }) { (flag) in
                    if flag {
                        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.tapToUnTrigger))
                        self.blurView.addGestureRecognizer(tapGesture)
                        self.finishAnimation()
                        
                    }
                }
                triggered = true
            }
            
        } else {
            tapToUnTrigger()
        }
    }
    
    @objc func tapToUnTrigger() {
        if let keyWindow = keyWindow {
            UIView.animate(withDuration: 0.3) {
                self.frame = CGRect(x: -keyWindow.frame.width / 2 - self.menuBlankWidth, y: 0, width: keyWindow.frame.width / 2 + self.menuBlankWidth , height: keyWindow.frame.height)
            }
            beforeAnimation()
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.9, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.helperSideView.center = CGPoint(x: -self.helperSideView.frame.width / 2, y: self.helperSideView.frame.height / 2)
            }) { (_) in
                self.finishAnimation()
            }
            
            UIView.animate(withDuration: 0.3) {
                self.blurView.alpha = 0
            }
            beforeAnimation()
            UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: [.beginFromCurrentState, .allowUserInteraction], animations: {
                self.helperCenterView.center = CGPoint(x: -self.helperCenterView.frame.width / 2, y: self.frame.height / 2)
            }) { (_) in
                self.finishAnimation()
            }
        }
        triggered = false
    }
}


extension SlideMenu {
    
    fileprivate func setupViews() -> Void {
        if let keyWindow = keyWindow {
            blurView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
            blurView.frame = keyWindow.frame
            blurView.alpha = 0
            
            helperSideView = UIView(frame: CGRect(x: -40, y: 0, width: 40, height: 40))
            helperSideView.backgroundColor = .red
            helperSideView.isHidden = true
            keyWindow.addSubview(helperSideView)
            
            helperCenterView = UIView(frame: CGRect(x: -40, y: keyWindow.frame.height / 2 - 20, width: 40, height: 40))
            helperCenterView.backgroundColor = .yellow
            helperCenterView.isHidden = true
            keyWindow.addSubview(helperCenterView)
            
            backgroundColor = .clear
            keyWindow.insertSubview(self, belowSubview: helperSideView)

        }
    }
    
    
    
    fileprivate func beforeAnimation() {
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(displayLinkAction(displayLink:)))
            displayLink?.add(to: .main, forMode: .defaultRunLoopMode)
        }
        animationCount += 1
    }
    
    fileprivate func finishAnimation() {
        animationCount -= 1
        if animationCount == 0 {
            displayLink?.invalidate()
            displayLink = nil
        }
    }
    
    
    @objc private func displayLinkAction(displayLink: CADisplayLink) {
        let sideHelperPresentationLayer = helperSideView.layer.presentation()
        let centerHelperPresentationLayer = helperCenterView.layer.presentation()
        
        let centerRect = centerHelperPresentationLayer?.value(forKeyPath: "frame") as? CGRect
        let sideRect = sideHelperPresentationLayer?.value(forKeyPath: "frame") as? CGRect
        
        if let centerRect = centerRect, let sideRect = sideRect {
            diff = sideRect.origin.x - centerRect.origin.x
            
            print("diff is \(diff)")
        }
        setNeedsDisplay()
        
        
    }
    
    
    
}








