//
//  CLShapeLayer.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/3.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

class CLShapeLayer: CAShapeLayer {
        
    
    /// path  路径
    /// fillColor  填充颜色
    /// fillRule  填充规则(‘非零’，‘奇偶’)
    /// strokeColor  渲染颜色
    /// strokeStart  渲染初始值
    /// strokeEnd  渲染结束值
    /// lineWidth  线宽(渲染)
    /// miterLimit  最大斜长度（当lineJoin属性为kCALineJoinMiter生效）
    /// lineCap  线两端的样式
    /// lineJoin  连接点类型
    /// lineDashPhase  虚线开始的位置
    /// lineDashPattern  虚线设置
    
    /// demo of animation with a snow image position at the path
    static func show(inView view: UIView) {
        
        //fllower path
        let bezierPath = UIBezierPath()
        bezierPath.move(to: view.center)
        bezierPath.addQuadCurve(to: CGPoint(x: 80, y: view.center.y - 90), controlPoint: CGPoint(x: view.center.x + 50, y: view.center.y - 90))
        bezierPath.addQuadCurve(to: view.center, controlPoint: CGPoint(x: 80, y: view.center.y - 20))
        bezierPath.addQuadCurve(to: CGPoint(x: 80, y: view.center.y + 90), controlPoint: CGPoint(x: view.center.x + 50, y: view.center.y + 90))
        bezierPath.addQuadCurve(to: view.center, controlPoint: CGPoint(x: 80, y: view.center.y + 20))
        bezierPath.addQuadCurve(to: CGPoint(x: screenWidth - 80, y: view.center.y + 90), controlPoint: CGPoint(x: view.center.x - 50, y: view.center.y + 90))
        bezierPath.addQuadCurve(to: view.center, controlPoint: CGPoint(x: screenWidth - 80, y: view.center.y + 20))
        bezierPath.addQuadCurve(to: CGPoint(x: screenWidth - 80, y: view.center.y - 90), controlPoint: CGPoint(x: view.center.x - 50, y: view.center.y - 90))
        bezierPath.addQuadCurve(to: view.center, controlPoint: CGPoint(x: screenWidth - 80, y: view.center.y - 20))
        
        //layer
        let shapeLayer = CLShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = .round
        shapeLayer.lineCap = .round
        shapeLayer.path = bezierPath.cgPath
        view.layer.addSublayer(shapeLayer)
        
        //CABasicAnimation
        let pathAnim = CABasicAnimation(keyPath: "strokeEnd")
        pathAnim.duration = 5.0
        pathAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        pathAnim.fromValue = 0
        pathAnim.toValue = 1
        pathAnim.autoreverses = true// 动画是否按原路径返回
        pathAnim.fillMode = .forwards
        pathAnim.repeatCount = Float.infinity
        shapeLayer.add(pathAnim, forKey: "strokeEndAnim")
        
        //snow
        let snow = UIImageView.init(image: UIImage.init(named: "snow"))
        snow.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.addSubview(snow)
        
        //CAKeyframeAnimation
        let keyAnima = CAKeyframeAnimation.init(keyPath: "position")
        keyAnima.duration = 5.0
        keyAnima.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        keyAnima.path = bezierPath.cgPath
        keyAnima.autoreverses = true
        keyAnima.repeatCount = Float.infinity
        keyAnima.fillMode = .forwards
        snow.layer.add(keyAnima, forKey: "moveAnimation")
    }
    
}
