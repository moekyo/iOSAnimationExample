//
//  DragBubbleViewController.swift
//  iOSAnimationExample
//
//  Created by moekyo on 2018/8/10.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

class DragBubbleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var option = BubbleOptions()
        option.viscosity = 20.0
        option.bubbleWidth = 35.0
        option.bubbleColor = UIColor(red: 0.0, green: 0.722, blue: 1.0, alpha: 1.0)
        
        
        
        let bounds = UIScreen.main.bounds
        
        let bubbleView = DragBubbleView(point: CGPoint(x: bounds.width / 2 - option.bubbleWidth / 2, y: bounds.height / 2 - option.bubbleWidth / 2), superView: view, options: option)
        option.text = "20"
        bubbleView.bubbleOptions = option

        
    }


}
