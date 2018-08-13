//
//  LiquittableCircle.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/13.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit
import Foundation

class LiquittableCircle: UIView {

    var points: [CGPoint] = []
    var isGrow = false {
        didSet {
            grow(isGrow: isGrow)
        }
    }
    var radius: CGFloat {
        didSet {
            setup()
        }
    }
    var color: UIColor = UIColor.red
    
    init(center: CGPoint, radius: CGFloat, color: UIColor) {
        let frame = CGRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius)
        self.radius = radius
        self.color = color
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func move(dt: CGPoint) {
        let point = CGPoint(x: center.x + dt.x, y: center.y + dt.y)
        self.center = point
    }
    
    private func setup() {
        self.frame = CGRect(x: center.x - radius, y: center.y - radius, width: 2 * radius, height: 2 * radius)
        let bezierPath = UIBezierPath(ovalIn: CGRect(origin: CGPoint.zero, size: CGSize(width: radius * 2, height: radius * 2)))
        
        draw(path:bezierPath)
    }
    
    func draw(path: UIBezierPath) {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        let layer = CAShapeLayer(layer: self.layer)
        layer.lineWidth = 3.0
        layer.fillColor = self.color.cgColor
        layer.path = path.cgPath
        self.layer.addSublayer(layer)
        if isGrow {
            grow(isGrow: true)
        }
    }
    
    func grow(isGrow: Bool) {
        if isGrow {
            grow(baseColor: self.color, radius: self.radius, shininess: 1.6)
        } else {
            self.layer.shadowRadius = 0
            self.layer.shadowOpacity = 0
        }
    }
    
    func circlePoint(rad: CGFloat) -> CGPoint {
        
        return CGMath.circlePoint(center: center, radius: radius, rad: rad)
    }

}
