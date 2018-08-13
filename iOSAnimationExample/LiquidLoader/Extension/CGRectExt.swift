//
//  CGRectExt.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/13.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    var rightBottom: CGPoint {
        get {
            return CGPoint(x: origin.x + width, y: origin.y + height)
        }
    }
    var center: CGPoint {
        get {
            return origin.plus(point: rightBottom).mul(rhs: 0.5)
        }
    }
}
