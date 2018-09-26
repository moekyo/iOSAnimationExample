//
//  AppDelegate.swift
//  iOSAnimationExample
//
//  Created by moekyo on 2018/8/3.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.makeKeyAndVisible()
        window?.backgroundColor = #colorLiteral(red: 0.2588235294, green: 0.6705882353, blue: 1, alpha: 1)
        print("launchOptions is \(application)")
        guard let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() else { return true }
//        一定要设置 window 的 rootViewController, 不然不显示 mask
        window?.rootViewController = navigationController
//        guard let nav = window?.rootViewController else { return true }
        
        
        let logo = #imageLiteral(resourceName: "logo1").cgImage
        
        let maskLayer = CALayer()
        maskLayer.contents = logo
        let width: CGFloat = 60.0
        maskLayer.frame = CGRect(x: 0, y: 0, width: width, height: width)
        maskLayer.position = navigationController.view.center
        navigationController.view.layer.mask = maskLayer
        
        let maskBackgroundView = UIView(frame: navigationController.view.bounds)
        maskBackgroundView.backgroundColor = .white
        navigationController.view.addSubview(maskBackgroundView)
        navigationController.view.bringSubview(toFront: maskBackgroundView)
        
        //logo mask animation
        let logoMaskAnimaiton = CAKeyframeAnimation(keyPath: "bounds")
        logoMaskAnimaiton.duration = 1.0
        logoMaskAnimaiton.beginTime = CACurrentMediaTime() + 1.0

        
        let initalBounds = maskLayer.bounds
        let secondBounds = CGRect(x: 0, y: 0, width: 50, height: 50)
        let finalBounds  = CGRect(x: 0, y: 0, width: 2000, height: 2000)
        logoMaskAnimaiton.values = [initalBounds, secondBounds, finalBounds]
        logoMaskAnimaiton.keyTimes = [0.0, 0.5, 1.0]
        logoMaskAnimaiton.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut), CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
        logoMaskAnimaiton.isRemovedOnCompletion = false
        logoMaskAnimaiton.fillMode = kCAFillModeForwards
        navigationController.view.layer.mask?.add(logoMaskAnimaiton, forKey: "logoMaskAnimaiton")
        
        UIView.animate(withDuration: 0.1, delay: 1.35, options: .curveEaseIn, animations: { () -> Void in
            maskBackgroundView.alpha = 0.0
        }) { (finished) -> Void in
            maskBackgroundView.removeFromSuperview()
        }
        
        UIView.animate(withDuration: 0.25, delay: 1.3, options: [], animations: { () -> Void in
            navigationController.view.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        }) { (finished) -> Void in
            UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: { () -> Void in
                navigationController.view.transform = .identity
            }, completion: { (finished) -> Void in
                navigationController.view.layer.mask = nil
            })
        }
        

        return true
    }



}

