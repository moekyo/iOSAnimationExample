//
//  JumpStar.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/11/1.
//  Copyright © 2018 moekyo. All rights reserved.
//

import UIKit

class ButtonInteraction: UIViewController {

    @IBOutlet weak var downloadButton: DownloadButton!
    @IBOutlet weak var jumpStarView: JumpStarView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jumpStarView.layoutIfNeeded()
        let option = JumpStarOptions(markedImage: UIImage(named: "icon_star_incell")!, non_markedImage: UIImage(named: "blue_dot")!, jumpDuration: 0.125, downDuration: 0.215)
        jumpStarView.options = option
        jumpStarView.state = .NONMark
        
        downloadButton.progressBarWidth  = 200
        downloadButton.progressBarHeight = 30


    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        jumpStarView.animate()
    }
    

}
