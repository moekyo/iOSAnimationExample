//
//  LiquidLineEffect.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/13.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import Foundation
import UIKit

class LiquidLineEffect : LiquidLoadEffect {
    
    let NumberOfCircles = 5
    var circleInter: CGFloat!
    
    override func setupShape() -> [LiquittableCircle] {
        return Array(0..<NumberOfCircles).map { i in
            return LiquittableCircle(
                center: CGPoint(x: self.circleInter + self.circleRadius + CGFloat(i) * (self.circleInter + 2 * self.circleRadius), y: self.loader.frame.height * 0.5),
                radius: self.circleRadius,
                color: self.color
            )
        }
    }
    
    override func movePosition(key: CGFloat) -> CGPoint {
        if loader != nil {
            return CGPoint(
                x: loader.frame.width * sineTransform(key: key),
                y: loader.frame.height * 0.5
            )
        } else {
            return CGPoint.zero
        }
    }
    
    func sineTransform(key: CGFloat) -> CGFloat {
        return sin(key * CGFloat.pi) * 0.5 + 0.5
    }
    
    override func update() {
        if  duration != 0 {
            switch key {
            case 0.0...2.0:
                key += CGFloat(2.0/(duration!*60))
            default:
                key = 0.0
            }
        } else {
            switch key {
            case 0.0...1.0:
                key += 0.006
            default:
                key = key - 1.0
            }
        }


    }
    
    override func willSetup() {
        if circleRadius == nil {
            circleRadius = loader.frame.width * 0.05
        }
        self.circleInter = (loader.frame.width - 2 * circleRadius * 5) / 6
        self.engine = SimpleCircleLiquidEngine(radiusThresh: self.circleRadius, angleThresh: 0.2)
        let moveCircleRadius = circleRadius * moveScale
        self.moveCircle = LiquittableCircle(center: CGPoint(x: 0, y: loader.frame.height * 0.5), radius: moveCircleRadius, color: color)
    }
    
    override func resize() {
        circles.map { circle in
            return (circle, circle.center.minus(point: self.moveCircle!.center).length())
            }.forEach { ( circle, distance) in
                let normalized = 1.0 - distance / (self.circleRadius + self.circleInter)
                if normalized > 0.0 {
                    circle.radius = self.circleRadius + (self.circleRadius * self.circleScale - self.circleRadius) * normalized
                } else {
                    circle.radius = self.circleRadius
                }
        }
    }
    
}
