//
//  AnimatedCircle.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/3.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit
import Spring

class AnimatedCircle: UIViewController {

    @IBOutlet weak var currentValueLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var circeleContainerView: DesignableView!
    var constraints: [NSLayoutConstraint]!
    
    
    var circleView: CircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        circleView = CircleView(frame: CGRect(x: view.frame.size.width/2 - 320/2, y: 100, width: 320, height: 320))
        circleView.circleLayer.progress = CGFloat(slider.value)
        circeleContainerView.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.topAnchor.constraint(equalTo: circeleContainerView.topAnchor).isActive = true
        circleView.bottomAnchor.constraint(equalTo: circeleContainerView.bottomAnchor).isActive = true
        circleView.leftAnchor.constraint(equalTo: circeleContainerView.leftAnchor).isActive = true
        circleView.rightAnchor.constraint(equalTo: circeleContainerView.rightAnchor).isActive = true
        
        
        
    
        slider.addTarget(self, action: #selector(sliderValueChanged(slider:)), for: .valueChanged)
        
    }
    
    
    
    
    
    func test() -> Void {
        let blueView = UIView(frame: CGRect(x: 40, y: 60, width: 200, height: 200))
        blueView.backgroundColor = .blue
        view.addSubview(blueView)
        
        
        let redView = UIView(frame: CGRect(x: 40, y: 60, width: 200, height: 200))
        redView.backgroundColor = .red
        redView.alpha = 0.4
        view.addSubview(redView)
        redView.layer.anchorPoint = CGPoint(x: 1, y: 1)
        redView.layer.position = CGPoint(x: 240, y: 260)
        print(redView.layer.position)
        print(redView.frame)
        
        
        
        
        let startPoint = CGPoint(x: 50, y: 300)
        let endPoint = CGPoint(x:300, y:300)
        let controlPoint = CGPoint(x:170, y:200)
        
        let layer1 = CALayer()
        layer1.frame = CGRect(x:startPoint.x, y:startPoint.y,width: 5, height:5)
        layer1.backgroundColor = UIColor.red.cgColor
        
        let layer2 = CALayer()
        layer2.frame = CGRect(x:endPoint.x, y:endPoint.y, width: 5, height:5)
        layer2.backgroundColor = UIColor.red.cgColor
        
        let layer3 = CALayer()
        layer3.frame = CGRect(x:controlPoint.x, y:controlPoint.y,width: 5, height:5)
        layer3.backgroundColor = UIColor.red.cgColor
        
        let path = UIBezierPath()
        let layer = CAShapeLayer()
        
        path.move(to: startPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.black.cgColor
        
        view.layer.addSublayer(layer)
        view.layer.addSublayer(layer1)
        view.layer.addSublayer(layer2)
        view.layer.addSublayer(layer3)
        
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.5
        animation.toValue = 1
        animation.duration = 2
        layer.add(animation, forKey: nil)

    }
    
    @IBAction func switchAction(_ sender: UISwitch) {
        print(sender.isOn)
        circleView.showHelper = sender.isOn
        
    }
    @objc func sliderValueChanged(slider: UISlider) {
        currentValueLabel.text = "Current: \(slider.value)"
        circleView.circleLayer.progress = CGFloat(slider.value)
    }

}
