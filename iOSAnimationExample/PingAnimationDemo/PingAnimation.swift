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
   
    fileprivate func backBtnAnimaiton() {
        let duration: CFTimeInterval = 5
        
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.calculationMode = kCAAnimationPaced
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.repeatCount = Float.infinity
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.duration = duration
        
        
        let circlePath = UIBezierPath(ovalIn: self.backBtn.frame.insetBy(dx: 25, dy: 10))
        pathAnimation.path = circlePath.cgPath
        self.backBtn.layer.add(pathAnimation, forKey: nil)
        
        
        let scaleX = CAKeyframeAnimation(keyPath:"transform.scale.x")
        scaleX.values   =  [0.9, 1.1, 1.0]
        scaleX.keyTimes =  [0.0, 0.5,1.0]
        scaleX.repeatCount = Float.infinity
        scaleX.autoreverses = true
        scaleX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        scaleX.duration = duration
        self.backBtn.layer.add(scaleX, forKey: "scaleXAnimation")
        
        let scaleY = CAKeyframeAnimation(keyPath:"transform.scale.y")
        scaleY.values = [0.9, 1.1, 1.0]
        scaleY.keyTimes = [0.0, 0.5,1.0]
        scaleY.repeatCount = Float.infinity
        scaleY.autoreverses = true
        scaleY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        scaleY.duration = duration
        self.backBtn.layer.add(scaleY, forKey: "scaleYAnimation")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.delegate = self
        self.button.layer.cornerRadius = self.button.bounds.width / 2
        self.backBtn.layer.cornerRadius = self.backBtn.bounds.height / 2
        
        backBtnAnimaiton()
        
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
