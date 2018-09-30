//
//  PingTransition.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/9/28.
//  Copyright © 2018 moekyo. All rights reserved.
//

import UIKit

class PingTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionContext:UIViewControllerContextTransitioning!
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.7
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext

        if (transitionContext.viewController(forKey: .from)?.isKind(of: PingAnimation.self))! {
            let fromVC = transitionContext.viewController(forKey: .from) as! PingAnimation
            let toVC = transitionContext.viewController(forKey: .to) as! SecondViewController
            transitionContext.containerView.addSubview(fromVC.view)
            transitionContext.containerView.addSubview(toVC.view)
            
            guard let trigger = fromVC.button else { return }
            self.addAnimation(trigger: trigger, from: fromVC.view, to: toVC.view, isPush: true)
        } else {
            let fromVC = transitionContext.viewController(forKey: .from) as! SecondViewController
            let toVC = transitionContext.viewController(forKey: .to) as! PingAnimation
            transitionContext.containerView.addSubview(toVC.view)
            transitionContext.containerView.addSubview(fromVC.view)
            guard let trigger = fromVC.button else { return }
            self.addAnimation(trigger: trigger, from: fromVC.view, to: toVC.view, isPush: false)
        }
    }
    

    func addAnimation(trigger: UIView, from: UIView, to: UIView, isPush: Bool) {
        
        
        let originPath = UIBezierPath(ovalIn: trigger.frame)
        
        let extremePoint = CGPoint(x: trigger.center.x, y: trigger.center.y - from.bounds.height)
        let radius = sqrt(extremePoint.x * extremePoint.x + extremePoint.y * extremePoint.y)
        let finalPath = UIBezierPath(ovalIn: trigger.frame.insetBy(dx: -radius, dy: -radius))
        
        
        let mask = CAShapeLayer()
        
        
        let animation = CABasicAnimation(keyPath: "path")
        if !isPush {
            animation.fromValue = finalPath.cgPath
            animation.toValue = originPath.cgPath
            from.layer.mask = mask
        } else {
            animation.fromValue = originPath.cgPath
            animation.toValue = finalPath.cgPath
            to.layer.mask = mask
        }

        animation.delegate = self
        animation.duration = self.transitionDuration(using: transitionContext)
        mask.add(animation, forKey: nil)
    }
    
    
}


extension PingTransition: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.transitionContext.completeTransition(true)
        self.transitionContext.viewController(forKey: .to)?.view.layer.mask = nil
        self.transitionContext.viewController(forKey: .from)?.view.layer.mask = nil
    }
}
