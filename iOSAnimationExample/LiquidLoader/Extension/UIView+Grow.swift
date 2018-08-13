//
//  UIView+Grow.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/13.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func grow(baseColor: UIColor, radius: CGFloat, shininess: CGFloat) {
        let growColor = UIColor(red: 0 / 255.0, green: 1, blue: 1, alpha: 1.0)
        growShadow(radius: radius, growColor: growColor, shininess: shininess)
        let circle = CAShapeLayer()
        circle.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0)).cgPath
        let circleGradient = CircularGradientLayer(colors: [growColor, UIColor(white: 1.0, alpha: 0)])
        circleGradient.frame = CGRect(x: 0, y: 0, width: radius * 2.0, height: radius * 2.0)
        circleGradient.opacity = 0.25
        for sub in layer.sublayers! {
            if let l = sub as? CAShapeLayer {
                l.fillColor = UIColor.clear.cgColor
            }
        }
        circleGradient.mask = circle
        layer.addSublayer(circleGradient)
    }
    
    func growShadow(radius: CGFloat, growColor: UIColor, shininess: CGFloat) {
        let origin = self.center.minus(point: self.frame.origin).minus(point: CGPoint(x: radius * shininess, y: radius * shininess))
        let ovalRect = CGRect(origin: origin, size: CGSize(width: 2 * radius * shininess, height: 2 * radius * shininess))
        let shadowPath = UIBezierPath(ovalIn: ovalRect)
        self.layer.shadowColor = growColor.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowOpacity = 1.0
        self.layer.shouldRasterize = true
        self.layer.shadowOffset = CGSize.zero
        self.layer.masksToBounds = false
        self.clipsToBounds = false
    }

}
