//
//  LiquidLoader.swift
//  iOSAnimationExample
//
//  Created by moekyo on 2018/8/10.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

public enum Effect {
    case Line(UIColor)
    case Circle(UIColor)
    case GrowLine(UIColor)
    case GrowCircle(UIColor)
    
    func setup(loader: LiquidLoader) -> LiquidLoadEffect {
        switch self {
        case .Line(let color):
            return LiquidLineEffect(loader: loader, color: color)
        case .Circle(let color):
            return LiquidCircleEffect(loader: loader, color: color)
        case .GrowLine(let color):
            let growLine = LiquidLineEffect(loader: loader, color: color)
            growLine.isGrow = true
            return growLine
        case .GrowCircle(let color):
            let growCircle = LiquidCircleEffect(loader: loader, color: color)
            growCircle.isGrow = true
            return growCircle
        }
    }
}


class LiquidLoader: UIView {
    private let effect: Effect
    private var effectDelegate: LiquidLoadEffect?
    

    public init(frame: CGRect, effect: Effect, duration: TimeInterval = 0) {
        self.effect = effect
        super.init(frame: frame)
        self.effectDelegate = self.effect.setup(loader: self)
        self.effectDelegate?.duration = duration
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.effect = .Circle(UIColor.white)
        super.init(coder: aDecoder)!
        self.effectDelegate = self.effect.setup(loader: self)
        self.effectDelegate?.duration = 0
    }
    
    public func show() {
        self.isHidden = false
    }
    
    public func hide() {
        self.isHidden = true
    }

}
