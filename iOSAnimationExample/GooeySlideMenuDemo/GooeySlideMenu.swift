//
//  GooeySlideMenu.swift
//  iOSAnimationExample
//
//  Created by moekyo on 2018/8/9.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

class GooeySlideMenu: UIViewController {
    let menu = SlideMenu(frame: .zero)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        //不用加到 view,因为已经加到了 keyWindow 上了
//        view.addSubview(menu)
        
    }

    
    @IBAction func trigger(_ sender: UIButton) {
        menu.trigger()
    }
    

}
