//
//  DragBubbleView.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/10.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

struct BubbleOptions {
    var text: String = ""
    var bubbleWidth: CGFloat = 0.0
    var viscosity: CGFloat = 0.0
    var bubbleColor: UIColor = .white
}

class DragBubbleView: UIView {

    var bubbleOptions: BubbleOptions!{
        didSet{
            bubbleLabel.text = bubbleOptions.text
        }
    }

    
    fileprivate var frontView: UIView!
    fileprivate var backView: UIView!
    fileprivate var containerView: UIView!
    fileprivate var bubbleLabel: UILabel!
    fileprivate var cutePath: UIBezierPath!
    fileprivate var fillColorForCute: UIColor!
    fileprivate var shapeLayer: CAShapeLayer!
   
    fileprivate var r1: CGFloat = 0.0
    fileprivate var r2: CGFloat = 0.0
    fileprivate var x1: CGFloat = 0.0
    fileprivate var y1: CGFloat = 0.0
    fileprivate var x2: CGFloat = 0.0
    fileprivate var y2: CGFloat = 0.0
    fileprivate var centerDistance: CGFloat = 0.0
    fileprivate var cosDigree: CGFloat = 0.0
    fileprivate var sinDigree: CGFloat = 0.0
    
    fileprivate var pointA = CGPoint.zero
    fileprivate var pointB = CGPoint.zero
    fileprivate var pointC = CGPoint.zero
    fileprivate var pointD = CGPoint.zero
    fileprivate var pointO = CGPoint.zero
    fileprivate var pointP = CGPoint.zero
    
    fileprivate var initialPoint: CGPoint = CGPoint.zero
    fileprivate var oldBackViewFrame: CGRect = CGRect.zero
    fileprivate var oldBackViewCenter: CGPoint = CGPoint.zero
    
    
    init(point: CGPoint, superView: UIView, options: BubbleOptions) {
        super.init(frame: CGRect(x: point.x, y: point.y, width: options.bubbleWidth, height: options.bubbleWidth))
        bubbleOptions = options
        initialPoint = point
        containerView = superView
        containerView.addSubview(self)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setup() {
        shapeLayer = CAShapeLayer()
        backgroundColor = .clear
        frontView = UIView(frame: CGRect(x: initialPoint.x, y: initialPoint.y, width: bubbleOptions.bubbleWidth, height: bubbleOptions.bubbleWidth))
        
        r2 = frontView.frame.width / 2
        frontView.layer.cornerRadius = r2
        frontView.backgroundColor = bubbleOptions.bubbleColor
        
        backView = UIView(frame: frontView.frame)
        r1 = backView.frame.width / 2
        backView.layer.cornerRadius = r1
        backView.backgroundColor = bubbleOptions.bubbleColor
        
        bubbleLabel = UILabel()
        bubbleLabel.frame = frontView.bounds
        bubbleLabel.textColor = .white
        bubbleLabel.textAlignment = .center
        bubbleLabel.text = bubbleOptions.text
        
        frontView.insertSubview(bubbleLabel, at: 0)
        containerView.addSubview(backView)
        containerView.addSubview(frontView)
        
        x1 = backView.center.x
        y1 = backView.center.y
        x2 = frontView.center.x
        y2 = frontView.center.y
        
        pointA = CGPoint(x: x1 - r1, y: y1)
        pointB = CGPoint(x: x1 + r1, y: y1)
        pointC = CGPoint(x: x2 + r2, y: y2)
        pointD = CGPoint(x: x2 - r2, y: y2)
        pointO = CGPoint(x: x1 - r1, y: y1)
        pointP = CGPoint(x: x2 + r2, y: y2)
        
        oldBackViewFrame = backView.frame
        oldBackViewCenter = backView.center
        
        backView.isHidden = true
        addAniamtionLikeGameCenterBubble()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        frontView.addGestureRecognizer(panGesture)
        
    }
    
    
    override func draw(_ rect: CGRect) {
        guard let frontView = frontView else { return }
        
        x1 = backView.center.x
        y1 = backView.center.y
        x2 = frontView.center.x
        y2 = frontView.center.y
        
        let xtimesx = (x2 - x1) * (x2 - x1)
        centerDistance = sqrt(xtimesx + (y2 - y1) * (y2 - y1))
        if centerDistance == 0 {
            cosDigree = 1
            sinDigree = 0
        } else {
            cosDigree = (y2 - y1) / centerDistance
            sinDigree = (x2 - x1) / centerDistance
        }
        
        r1 = oldBackViewFrame.width / 2 - centerDistance / bubbleOptions.viscosity
        pointA = CGPoint(x: x1 - r1 * cosDigree, y: y1 + r1 * sinDigree)
        pointB = CGPoint(x: x1 + r1 * cosDigree, y: y1 - r1 * sinDigree)
        pointC = CGPoint(x: x2 + r2 * cosDigree, y: y2 - r2 * sinDigree)
        pointD = CGPoint(x: x2 - r2 * cosDigree, y: y2 + r2 * sinDigree)
        pointO = CGPoint(x: pointA.x + (centerDistance / 2) * sinDigree, y: pointA.y + (centerDistance / 2) * cosDigree)
        pointP = CGPoint(x: pointB.x + (centerDistance / 2) * sinDigree, y: pointB.y + (centerDistance / 2) * cosDigree)
        
        backView.center = oldBackViewCenter
        backView.bounds = CGRect(x: 0, y: 0, width: r1 * 2, height: r1 * 2)
        backView.layer.cornerRadius = r1
        
        cutePath = UIBezierPath()
        cutePath.move(to: pointA)
        cutePath.addQuadCurve(to: pointD, controlPoint: pointO)
        cutePath.addLine(to: pointC)
        cutePath.addQuadCurve(to: pointB, controlPoint: pointP)
        cutePath.addLine(to: pointA)
        
        if backView.isHidden == false {
            shapeLayer.path = cutePath.cgPath
            shapeLayer.fillColor = fillColorForCute.cgColor
            containerView.layer.insertSublayer(shapeLayer, below: frontView.layer)
        }
        
        
    }

}





extension DragBubbleView {
    
    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let dragPoint = gesture.location(in: containerView)
        if gesture.state == .began {
            r1 = oldBackViewFrame.width / 2
            backView.isHidden = false
            fillColorForCute = bubbleOptions.bubbleColor
            removeAniamtionLikeGameCenterBubble()
        } else if gesture.state == .changed {
            frontView.center = dragPoint
            if r1 <= 6 {
                fillColorForCute = .clear
                backView.isHidden = true
                shapeLayer.removeFromSuperlayer()
            }
            setNeedsDisplay()
        } else if gesture.state == .ended || gesture.state == .cancelled || gesture.state == .failed {
            backView.isHidden = true
            fillColorForCute = .clear
            shapeLayer.removeFromSuperlayer()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
                self.frontView.center = self.oldBackViewCenter
            }) { (_) in
                self.addAniamtionLikeGameCenterBubble()
            }
        }
        
        
    }
    
    private func addAniamtionLikeGameCenterBubble() {
        let pathAnimation = CAKeyframeAnimation(keyPath: "position")
        pathAnimation.calculationMode = kCAAnimationPaced
        
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.repeatCount = .infinity
        pathAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        pathAnimation.duration = 5.0
        
        let curvedPath = CGMutablePath()
        guard let frontView = frontView else {
            print("frontView is nil!")
            return
        }
        let circleContainer = self.frontView.frame.insetBy(dx: frontView.bounds.width / 2 - 3, dy: frontView.bounds.width / 2 - 3)
        
        curvedPath.addEllipse(in: circleContainer, transform: .identity)
        pathAnimation.path = curvedPath
//        frontView.layer.add(pathAnimation, forKey: "circleAnimation")
        
        let scaleX = CAKeyframeAnimation(keyPath: "transform.scale.x")
        scaleX.duration = 1.0
        scaleX.values = [1.0, 1.1, 1.0]
        scaleX.keyTimes = [0.0, 0.5, 1.0]
        scaleX.repeatCount = .infinity
        scaleX.autoreverses = true
        
        scaleX.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        frontView.layer.add(scaleX, forKey: "scaleXAnimation")
        
        let scaleY = CAKeyframeAnimation(keyPath: "transform.scale.y")
        scaleY.duration = 1.5
        scaleY.values = [1.0, 1.1, 1.0]

        scaleY.keyTimes = [0.0, 0.5, 1.0]
        scaleY.repeatCount = .infinity
        scaleY.autoreverses = true
        scaleY.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        frontView.layer.add(scaleY, forKey: "scaleYAnimation")
        
    }
    
    private func removeAniamtionLikeGameCenterBubble() {
        if let frontView = frontView {
            frontView.layer.removeAllAnimations()
        }
    }
    
}
