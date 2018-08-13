//
//  LiquidCircleEffect.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/13.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit
import Foundation

class LiquidCircleEffect: LiquidLoadEffect {
    var radius: CGFloat {
        get {
            return loader!.frame.width * 0.5
        }
    }
    let NumberOfCircles = 8
    
    internal override init(loader: LiquidLoader, color: UIColor) {
        super.init(loader: loader, color: color)
    }
    
    override func setupShape() -> [LiquittableCircle] {
        return Array(0..<NumberOfCircles).map { i in
            let angle = CGFloat(i) * CGFloat.pi * 2 / 8.0
            let frame = self.loader.frame
            let center = CGMath.circlePoint(center: frame.center.minus(point: frame.origin), radius: self.radius - self.circleRadius, rad: angle)
            return LiquittableCircle(
                center: center,
                radius: self.circleRadius,
                color: self.color
            )
        }
    }
    
    override func movePosition(key: CGFloat) -> CGPoint {
        let frame = self.loader!.frame.center.minus(point: self.loader!.frame.origin)
        return CGMath.circlePoint(
            center: frame,
            radius: self.radius - self.circleRadius,
            rad: self.key * CGFloat.pi * 2
        )
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
        self.circleRadius = loader.frame.width * 0.09
        self.circleScale = 1.10
        self.engine = SimpleCircleLiquidEngine(radiusThresh: self.circleRadius * 0.85, angleThresh: 0.5)
        let moveCircleRadius = circleRadius * moveScale
        moveCircle = LiquittableCircle(center: movePosition(key: 0.0), radius: moveCircleRadius, color: self.color)
    }
    
    override func resize() {
        let moveVec = moveCircle!.center.minus(point: loader.center.minus(point: loader.frame.origin)).normalized()
        circles.map { circle in
            return (circle, moveVec.dot(point: circle.center.minus(point: self.loader.center.minus(point: self.loader.frame.origin)).normalized()))
            }.forEach { ( circle, dot) in
                if 0.75 < dot && dot <= 1.0 {
                    let normalized = (dot - 0.75) / 0.25
                    let scale = normalized * normalized
                    circle.radius = self.circleRadius + (self.circleRadius * self.circleScale - self.circleRadius) * scale
                } else {
                    circle.radius = self.circleRadius
                }
        }
    }
}
