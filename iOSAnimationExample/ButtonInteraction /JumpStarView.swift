//
//  JumpStarView.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/11/1.
//  Copyright © 2018 moekyo. All rights reserved.
//

import UIKit


enum STATE {
    case NONMark
    case Mark
}

struct JumpStarOptions {

    var markedImage: UIImage?
    var non_markedImage: UIImage?
    var jumpDuration: TimeInterval
    var downDuration: TimeInterval

}

class JumpStarView: UIView {

    var options: JumpStarOptions!
    
    private var starView: UIImageView!
    private var shadowView: UIImageView!
    private var animating: Bool = false
    
    var state: STATE = .NONMark {
        didSet {
            starView.image = state == .NONMark ? options.non_markedImage : options.markedImage
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .clear
        
        if starView == nil {
            starView = UIImageView(frame: CGRect(x: bounds.width/2 - (bounds.width-6)/2, y: 0, width: bounds.width-6, height: bounds.height-6))
            starView.contentMode = .scaleToFill
            addSubview(starView)
        }
        if shadowView == nil {
            shadowView = UIImageView(frame: CGRect(x: bounds.width/2 - 10/2, y: bounds.height - 3, width: 10, height: 3))
            shadowView.alpha = 0.4
            shadowView.image = UIImage(named: "shadow_new")
            addSubview(shadowView)
        }
        
    }
    
    func animate() -> Void {
        if animating {
            return
        }
        
        animating = true
        let transformAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        transformAnimation.fromValue = 0.0
        transformAnimation.toValue = Double.pi / 2
        transformAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let positionAnimation = CABasicAnimation(keyPath: "position.y")
        positionAnimation.fromValue = starView.center.y
        positionAnimation.toValue = starView.center.y - 14.0
        positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = options.jumpDuration
        
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.isRemovedOnCompletion = false
        animationGroup.delegate = self
        animationGroup.animations = [transformAnimation, positionAnimation]
        starView.layer.add(animationGroup, forKey: "jumpUp")
        
    }
    
    
    
}

extension JumpStarView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        if anim == starView.layer.animation(forKey: "jumpUp") {
            UIView.animate(withDuration: options.jumpDuration, delay: 0.0, options: .curveEaseOut, animations: {
                self.shadowView.alpha = 0.2
                self.shadowView.bounds = CGRect(x: 0, y: 0, width: self.shadowView.bounds.width*1.6, height: self.shadowView.bounds.height)
            }, completion: nil)
        } else if anim == starView.layer.animation(forKey: "jumpDown") {
            UIView.animate(withDuration: options.downDuration, delay: 0.0, options: .curveEaseOut, animations: {
                self.shadowView.alpha = 0.4
                self.shadowView.bounds = CGRect(x: 0, y: 0, width: self.shadowView.bounds.width/1.6, height: self.shadowView.bounds.height)
            }, completion: nil)
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if anim == starView.layer.animation(forKey: "jumpUp") {
            state = state == .NONMark ? .Mark : .NONMark
            let transformAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
            transformAnimation.fromValue = Double.pi / 2
            transformAnimation.toValue = Double.pi
            transformAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            
            let positionAnimation = CABasicAnimation(keyPath: "position.y")
            positionAnimation.fromValue = starView.center.y - 14
            positionAnimation.toValue = starView.center.y
            positionAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
            
            let animationGroup = CAAnimationGroup()
            animationGroup.duration = options.downDuration
            animationGroup.fillMode = kCAFillModeForwards
            animationGroup.isRemovedOnCompletion = false
            animationGroup.delegate = self
            animationGroup.animations = [transformAnimation, positionAnimation]
            starView.layer.add(animationGroup, forKey: "jumpDown")
        } else if anim == starView.layer.animation(forKey: "jumpDown") {
            starView.layer.removeAllAnimations()
            animating = false
        }

    }
}
