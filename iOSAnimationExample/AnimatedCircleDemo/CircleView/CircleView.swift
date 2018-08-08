//
//  CircleView.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/3.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

class CircleView: UIView {
    var circleLayer = CircleLayer()
    
    var showHelper: Bool = true {
        willSet {
            circleLayer.showHelper = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        circleLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        circleLayer.contentsScale = UIScreen.main.scale
        layer.addSublayer(circleLayer)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

}
