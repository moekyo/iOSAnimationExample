//
//  DownloadButton.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/11/2.
//  Copyright © 2018 moekyo. All rights reserved.
//

import UIKit

let kRadiusShrinkAnim = "cornerRadiusShrinkAnim"
let kRadiusExpandAnim = "radiusExpandAnimation"
let kProgressBarAnimation = "progressBarAnimation"
let kCheckAnimation = "checkAnimation"

class DownloadButton: UIView {

    
    var progressBarWidth: CGFloat = 0.0
    var progressBarHeight: CGFloat = 0.0
    private var originFrame: CGRect = .zero
    private var animating: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpViews()
    }
    func setUpViews() -> Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleButtonDidTapped))
        addGestureRecognizer(tapGesture)
        
    }

    @objc func handleButtonDidTapped() {
        if animating {
            return
        }
        animating = true
        originFrame = frame
        layer.sublayers?.forEach({ (subLayer) in
            subLayer.removeFromSuperlayer()
        })
        backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        layer.cornerRadius = progressBarHeight / 2
        let radiusShrinkAnimation = CABasicAnimation(keyPath: "cornerRadius")
        radiusShrinkAnimation.duration = 0.2
        radiusShrinkAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        radiusShrinkAnimation.fromValue = originFrame.height / 2
        radiusShrinkAnimation.delegate = self
        layer.add(radiusShrinkAnimation, forKey: kRadiusShrinkAnim)
        
    }
    
    
    func progressBarAnimation() {
        let progressLayer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: progressBarHeight / 2, y: frame.height / 2))
        path.addLine(to: CGPoint(x: bounds.width - progressBarHeight / 2, y: bounds.height / 2))
        progressLayer.path = path.cgPath
        progressLayer.strokeColor = UIColor.white.cgColor
        progressLayer.lineWidth = progressBarHeight - 6
        progressLayer.lineCap = kCALineCapRound
        layer.addSublayer(progressLayer)
        
        
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 2.0
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.delegate = self
        
        pathAnimation.setValue(kProgressBarAnimation, forKey: "animationName")
        progressLayer.add(pathAnimation, forKey: nil)
    }
    func checkAnimation() {
        let checkLayer = CAShapeLayer()
        let path = UIBezierPath()
        
        let rectInCircle = self.bounds.insetBy(dx:self.bounds.size.width*(1-1/sqrt(2.0))/2, dy: self.bounds.size.width*(1-1/sqrt(2.0))/2)
        
        path.move(to: CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width/9, y: rectInCircle.origin.y + rectInCircle.size.height*2/3))
        path.addLine(to: CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width/3,y: rectInCircle.origin.y + rectInCircle.size.height*9/10))
        path.addLine(to: CGPoint(x: rectInCircle.origin.x + rectInCircle.size.width*8/10, y: rectInCircle.origin.y + rectInCircle.size.height*2/10))
        checkLayer.path = path.cgPath
        checkLayer.fillColor = UIColor.clear.cgColor
        checkLayer.strokeColor = UIColor.white.cgColor
        checkLayer.lineWidth = 10.0
        checkLayer.lineCap = kCALineCapRound
        checkLayer.lineJoin = kCALineJoinRound
        layer.addSublayer(checkLayer)
        
        let checkAnimation = CABasicAnimation(keyPath: "strokeEnd")
        checkAnimation.duration = 0.3
        checkAnimation.fromValue = 0.0
        checkAnimation.toValue = 1.0
        checkAnimation.delegate = self
        checkLayer.add(checkAnimation, forKey: nil)
        
        
    }

}

extension DownloadButton: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        if layer.animation(forKey: kRadiusShrinkAnim) == anim {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.bounds = CGRect(x: 0, y: 0, width: self.progressBarWidth, height: self.progressBarHeight)

            }) { (flag) in
                self.layer.removeAllAnimations()
                self.progressBarAnimation()

            }
        } else if layer.animation(forKey: kRadiusExpandAnim) == anim {
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.0, options: .curveEaseOut, animations: {
                self.bounds = CGRect(x: 0, y: 0, width: self.originFrame.width, height: self.originFrame.height)
                self.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)

            }) { (flag) in
                self.layer.removeAllAnimations()
                self.checkAnimation()
                self.animating = false

            }
        }
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationName = anim.value(forKey: "animationName") ,
            (animationName as AnyObject).isEqual(kProgressBarAnimation) {
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                if let sublayers = self.layer.sublayers{
                    for subLayer in sublayers {
                        subLayer.opacity = 0.0
                    }
                }
            }, completion: { (finished) -> Void in
                if let sublayers = self.layer.sublayers{
                    for sublayer in sublayers {
                        sublayer.removeFromSuperlayer()
                    }
                }
                self.layer.cornerRadius = self.originFrame.height / 2
                let radiusExpandAnimation = CABasicAnimation(keyPath: "cornerRadius")
                radiusExpandAnimation.duration = 0.2
                radiusExpandAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                radiusExpandAnimation.fromValue = self.progressBarHeight / 2
                radiusExpandAnimation.delegate = self
                self.layer.add(radiusExpandAnimation, forKey: kRadiusExpandAnim)
            })
        }    }
}
