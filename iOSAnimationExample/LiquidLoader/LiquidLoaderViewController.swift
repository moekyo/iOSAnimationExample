//
//  LiquidLoaderViewController.swift
//  iOSAnimationExample
//
//  Created by moekyo on 2018/8/10.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

class LiquidLoaderViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(red: 9 / 255.0, green: 21 / 255.0, blue: 37 / 255.0, alpha: 1.0)
        
        let lineColor = UIColor(red: 77 / 255.0, green: 255 / 255.0, blue: 182 / 255.0, alpha: 1.0)
        
        let lineFrame = CGRect(x: self.view.frame.width * 0.5 - 100, y: 100, width: 200, height: 100)
        let lineLoader = LiquidLoader(frame: lineFrame, effect: .GrowLine(lineColor), duration: 10)
//        let lineLoader = LiquidLoader(frame: lineFrame, effect: .GrowLine(lineColor))
        
        let circleFrame = CGRect(x: self.view.frame.width * 0.5 - 100, y: 200, width: 200, height: 200)
        let circleColor = UIColor(red: 77 / 255.0, green: 182 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        let circleLoader = LiquidLoader(frame: circleFrame, effect: .GrowCircle(circleColor))
        
        let circleMatColor = UIColor(red: 255 / 255.0, green: 188 / 255.0, blue: 188 / 255.0, alpha: 1.0)
        let circleMatFrame = CGRect(x: self.view.frame.width * 0.5 - 25, y: 450, width: 50, height: 50)
        let circleMat = LiquidLoader(frame: circleMatFrame, effect: .Circle(circleMatColor))
        
        let lineMatColor = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 188 / 255.0, alpha: 1.0)
        let lineMatFrame = CGRect(x: self.view.frame.width * 0.5 - 25, y: 500, width: 50, height: 50)
        let lineMat = LiquidLoader(frame: lineMatFrame, effect: .Line(lineMatColor))
        
        view.addSubview(lineLoader)
        view.addSubview(circleLoader)
        view.addSubview(circleMat)
        view.addSubview(lineMat)
        
        
        
    }


}
