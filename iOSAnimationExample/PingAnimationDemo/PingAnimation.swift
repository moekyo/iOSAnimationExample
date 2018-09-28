//
//  PingAnimation.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/9/28.
//  Copyright © 2018 moekyo. All rights reserved.
//

import UIKit

class PingAnimation: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        self.button.layer.cornerRadius = self.button.bounds.width / 2
        self.backBtn.layer.cornerRadius = self.backBtn.bounds.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func back(_ sender: UIButton) {
        self.navigationController?.delegate = nil;
        self.navigationController?.popViewController(animated: true)
    }
}

extension PingAnimation: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PingTransition()
    }
}
