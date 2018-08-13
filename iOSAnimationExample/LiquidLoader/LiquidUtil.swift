//
//  LiquidUtil.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/13.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import Foundation
import UIKit

func withBezier(f: (UIBezierPath) -> ()) -> UIBezierPath {
    let bezierPath = UIBezierPath()
    f(bezierPath)
    bezierPath.close()
    return bezierPath
}

func withStroke(bezierPath: UIBezierPath, color: UIColor, f: () -> ()) {
    color.setStroke()
    f()
    bezierPath.stroke()
}

func withFill(bezierPath: UIBezierPath, color: UIColor, f: () -> ()) {
    color.setFill()
    f()
    bezierPath.fill()
}

class CGMath {
    static func radToDeg(rad: CGFloat) -> CGFloat {
        return rad * 180 / CGFloat.pi
    }
    
    static func degToRad(deg: CGFloat) -> CGFloat {
        return deg * CGFloat.pi / 180
    }
    
    static func circlePoint(center: CGPoint, radius: CGFloat, rad: CGFloat) -> CGPoint {
        let x = center.x + radius * cos(rad)
        let y = center.y + radius * sin(rad)
        return CGPoint(x: x, y: y)
    }
    
    static func linSpace(from: CGFloat, to: CGFloat, n: Int) -> [CGFloat] {
        var values: [CGFloat] = []
        for i in 0..<n {
            values.append((to - from) * CGFloat(i) / CGFloat(n - 1) + from)
        }
        return values
    }
}

