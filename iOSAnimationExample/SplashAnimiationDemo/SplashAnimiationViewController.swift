//
//  SplashAnimiationViewController.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/13.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

class SplashAnimiationViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let logo = #imageLiteral(resourceName: "logo1").cgImage
        let maskLayer = CALayer()
        maskLayer.contents = logo
        let width: CGFloat = 60.0
        
        let x = view.bounds.width / 2 - width / 2
        
        maskLayer.frame = CGRect(x: x, y: 100, width: width, height: width)
        imageView.layer.mask = maskLayer

        
        
        
    }

}
