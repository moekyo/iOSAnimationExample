//
//  CircularGradientLayer.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/13.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit
import Foundation

class CircularGradientLayer: CALayer {
    let colors: [UIColor]
    init(colors: [UIColor]) {
        self.colors = colors
        super.init()
        setNeedsDisplay()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(in ctx: CGContext) {
        var locations = CGMath.linSpace(from: 0.0, to: 1.0, n: colors.count)
        locations = locations.map { (location) -> CGFloat in
            1.0 - location * location
        }.reversed()
        let gradients = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors.map { $0.cgColor } as CFArray, locations: locations)
        ctx.drawRadialGradient(gradients!, startCenter: self.frame.center, startRadius: CGFloat(0.0), endCenter: self.frame.center, endRadius: max(self.frame.width, self.frame.height), options: CGGradientDrawingOptions(rawValue: 10))
    }

}
