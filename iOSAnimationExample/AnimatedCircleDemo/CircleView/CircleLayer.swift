//
//  CircleLayer.swift
//  iOSAnimationExample
//
//  Created by edaotech on 2018/8/3.
//  Copyright © 2018年 moekyo. All rights reserved.
//

import UIKit

enum MovingPoint {
    case POINT_D
    case POINT_B
}
let outsideRectSize: CGFloat = 90

class CircleLayer: CALayer {
    
    private var outsideRect: CGRect!
    private var lastProgress: CGFloat = 0.5
    private var movePoint: MovingPoint!
    open var showHelper: Bool = true {
        didSet {
            setNeedsDisplay()
        }
    }
    var progress: CGFloat = 0.0 {
        didSet{
            //外接矩形在左侧，则改变B点；在右边，改变D点
            if progress <= 0.5 {
                movePoint = .POINT_B;
                print("B点动")
            }else{
                movePoint = .POINT_D;
                print("D点动")
            }
            
            lastProgress = progress
            let buff = (progress - 0.5) * (frame.size.width - outsideRectSize)
            let origin_x = position.x - outsideRectSize / 2 + buff
            let origin_y = position.y - outsideRectSize / 2;
            print("layer frame \(position)")
            outsideRect = CGRect(x: origin_x, y: origin_y, width: outsideRectSize, height: outsideRectSize)
            print("outsideRect \(outsideRect)")
            setNeedsDisplay()
        }
    }

    
    override func draw(in ctx: CGContext) {
        //A-C1、B-C2... 的距离，当设置为正方形边长的1/3.6倍时，画出来的圆弧完美贴合圆形
        let offset = self.outsideRect.size.width / 3.6
        //A.B.C.D实际需要移动的距离.系数为滑块偏离中点0.5的绝对值再乘以2.当滑到两端的时候，movedDistance为最大值：「外接矩形宽度的1/6」.
        let movedDistance = (outsideRect.size.width / 6) * CGFloat(fabs(progress - 0.5)) * 2
        //方便下方计算各点坐标，先算出外接矩形的中心点坐标
        let rectCenter = CGPoint(x: outsideRect.origin.x + outsideRect.width / 2, y: outsideRect.origin.y + outsideRect.height / 2)
        
        let pointA = CGPoint(x: rectCenter.x, y: outsideRect.origin.y + movedDistance)
        let pointB = CGPoint(x: movePoint == .POINT_D ? rectCenter.x + outsideRect.width / 2 : rectCenter.x + outsideRect.width / 2 + movedDistance * 2, y: rectCenter.y)
        let pointC = CGPoint(x: rectCenter.x, y: rectCenter.y + outsideRect.height / 2 - movedDistance)
        let pointD = CGPoint(x: movePoint == .POINT_D ? outsideRect.origin.x - movedDistance * 2 : outsideRect.origin.x, y: rectCenter.y)
        //控制点
        let c1 = CGPoint(x: pointA.x + offset, y: pointA.y)
        let c2 = CGPoint(x: pointB.x, y: movePoint == .POINT_D ? pointB.y - offset : pointB.y - offset + movedDistance)

        let c3 = CGPoint(x: pointB.x, y: movePoint == .POINT_D ? pointB.y + offset : pointB.y + offset - movedDistance)
        let c4 = CGPoint(x: pointC.x + offset, y: pointC.y)

        let c5 = CGPoint(x: pointC.x - offset, y: pointC.y)
        let c6 = CGPoint(x: pointD.x, y: movePoint == .POINT_D ? pointD.y + offset - movedDistance : pointD.y + offset)

        let c7 = CGPoint(x: pointD.x, y: movePoint == .POINT_D ? pointD.y - offset + movedDistance : pointD.y - offset)
        let c8 = CGPoint(x: pointA.x - offset, y: pointA.y)
        //外接虚线矩形
        if showHelper {
            let rectPath = UIBezierPath(rect: outsideRect)
            ctx.addPath(rectPath.cgPath)
            ctx.setStrokeColor(UIColor.black.cgColor)
            ctx.setLineWidth(1)
            let dash: [CGFloat] = [5.0,5.0]
            ctx.setLineDash(phase: 0, lengths: dash)
            ctx.strokePath()
        }
        
        //圆的边界
        let ovalPath = UIBezierPath()
        ovalPath.move(to: pointA)
        ovalPath.addCurve(to: pointB, controlPoint1: c1, controlPoint2: c2)
        ovalPath.addCurve(to: pointC, controlPoint1: c3, controlPoint2: c4)
        ovalPath.addCurve(to: pointD, controlPoint1: c5, controlPoint2: c6)
        ovalPath.addCurve(to: pointA, controlPoint1: c7, controlPoint2: c8)
        ovalPath.close()

        ctx.addPath(ovalPath.cgPath)
        ctx.setStrokeColor(UIColor.black.cgColor)
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.setLineDash(phase: 0, lengths: [])
        ctx.drawPath(using: .fillStroke)//同时给线条和线条包围的内部区域填充颜色
        
        //重新设置颜色
        ctx.setFillColor(UIColor.yellow.cgColor)
        ctx.setStrokeColor(UIColor.black.cgColor)
        
        if showHelper {
            [pointA, pointB, pointC, pointD, c1, c2, c3, c4, c5, c6, c7,c8].forEach { (point) in
                ctx.fill(CGRect(x: point.x - 2, y: point.y - 2, width: 4, height: 4))
            }
    
    
            //连接辅助线
            let helperline = UIBezierPath()
            helperline.move(to: pointA)
            helperline.addLine(to: c1)
            helperline.addLine(to: c2)
            helperline.addLine(to: pointB)
            helperline.addLine(to: c3)
            helperline.addLine(to: c4)
            helperline.addLine(to: pointC)
            helperline.addLine(to: c5)
            helperline.addLine(to: c6)
            helperline.addLine(to: pointD)
            helperline.addLine(to: c7)
            helperline.addLine(to: c8)
            helperline.close()
    
            ctx.addPath(helperline.cgPath)
            let dash2: [CGFloat] = [2.0, 2.0]
            ctx.setLineDash(phase: 0, lengths: dash2)
            ctx.strokePath()

        }
    }
    
    
    
    
}
