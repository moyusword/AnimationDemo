//
//  CLShapeLayer.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/3.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

class CLShapeLayer: CAShapeLayer {

    ///
    static func show(inView view: UIView) {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 50, y: 180))
        bezierPath.addLine(to: CGPoint(x: 325, y: 180))
        bezierPath.addLine(to: CGPoint(x: 80, y: 370))
        bezierPath.addLine(to: CGPoint(x: 275, y: 370))
        bezierPath.addLine(to: CGPoint(x: view.frame.width / 2, y: 300))
        bezierPath.addLine(to: CGPoint(x: view.frame.width / 2, y: 480))
        bezierPath.addLine(to: CGPoint(x: 30, y: 480))
        bezierPath.addLine(to: CGPoint(x: 345, y: 480))
        
        //画线
        let shapeLayer = CLShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.lineJoin = CAShapeLayerLineJoin.round
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.path = bezierPath.cgPath
        view.layer.addSublayer(shapeLayer)
        
        let pathAnim = CABasicAnimation(keyPath: "strokeEnd")
        pathAnim.duration = 5.0
        pathAnim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pathAnim.fromValue = 0//开始
        pathAnim.toValue = 1//到100%
        pathAnim.autoreverses = true// 动画按原路径返回
        pathAnim.fillMode = .forwards
        pathAnim.repeatCount = Float.infinity
        shapeLayer.add(pathAnim, forKey: "strokeEndAnim")
        
        
        //视图沿路径移动
        let moveV = UIImageView.init(image: UIImage.init(named: "snow"))
        moveV.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        moveV.center = CGPoint(x: 50, y: 100)
        view.addSubview(moveV)
        
        let keyAnima = CAKeyframeAnimation.init(keyPath: "position")
        keyAnima.duration = 5.0
        keyAnima.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        keyAnima.path = bezierPath.cgPath
        keyAnima.autoreverses = true
        keyAnima.repeatCount = Float.infinity
        keyAnima.fillMode = .forwards
        moveV.layer.add(keyAnima, forKey: "moveAnimation")
    }
    
}
