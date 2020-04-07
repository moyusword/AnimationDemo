//
//  CLReplicatorLayer.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/7.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

class CLReplicatorLayer: CAReplicatorLayer {
    
    /// instanceCount; //复制图层的个数，包括加到上面的
    /// preservesDepth; // 子图层是否平面化（看上面那个CATransformLayer）
    /// instanceDelay; // 复制层动画延迟时间
    /// instanceTransform; //子图层的transform变换，一般用来决定复制图层的初始位置以及初始试图变换
    /// instanceColor; // 复制层颜色，该颜色是与本体元素色值相乘，鬼知道是什么颜色
    /// instanceRedOffset; // 复制层红色偏移量
    /// instanceGreenOffset; // 复制层绿色偏移量
    /// instanceBlueOffset; // 复制层蓝色偏移量
    /// instanceAlphaOffset; // 复制层透明度偏移量

    
    /// creat layer from 'CAReplicatorLayer' and display in view.
    static func show(inView view: UIView) {
        
        let childLayer = CLReplicatorLayer()
        childLayer.wave(view)
        childLayer.circleDot(view)
        childLayer.followingPath(view)
    }
    
    /// demo of a music wave animation
    private func wave(_ view: UIView) {
        let replicatorLayer = CLReplicatorLayer()
        replicatorLayer.bounds = view.frame
        replicatorLayer.position = view.center
        view.layer.addSublayer(replicatorLayer)
        
        let layer = CALayer()
        layer.backgroundColor = UIColor.red.cgColor
        layer.bounds = CGRect(x: 0, y: 0, width: 10, height: 40)
        layer.position = CGPoint(x: 50, y: view.center.y)
        replicatorLayer.addSublayer(layer)
        
        let animation = CABasicAnimation(keyPath: "transform.scale.y")
        animation.toValue = 0.1
        animation.duration = 0.3
        animation.autoreverses = true
        animation.repeatCount = MAXFLOAT
        layer.add(animation, forKey: "LayerPositionWave")
        
        replicatorLayer.instanceCount = 8
        
        var transform = CATransform3DIdentity
        transform = CATransform3DTranslate(transform, 40, 0, 0)
        replicatorLayer.instanceTransform = transform
        replicatorLayer.instanceDelay = 0.3
    }
    
    /// demo of a circle dot loading animation
    private func circleDot(_ view: UIView) {
        
        let replicatorLayer = CLReplicatorLayer()
        replicatorLayer.bounds = view.frame;
        replicatorLayer.position = view.center;
        view.layer.addSublayer(replicatorLayer)
        
        let layer = CALayer()
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = 20
        layer.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
        layer.position = CGPoint(x: 50, y: view.center.y)
        replicatorLayer.addSublayer(layer)
        layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01);
        //
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 1
        animation.toValue = 0.1
        animation.duration = 0.75
        animation.repeatCount = MAXFLOAT
        layer.add(animation, forKey: "LayerPositionCircle")
        
        replicatorLayer.instanceCount = 15
        replicatorLayer.preservesDepth = true
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, CGFloat(Double.pi * 2 / 15.0), 0, 0, 1);
        replicatorLayer.instanceTransform = transform
        replicatorLayer.instanceDelay = 0.05
        replicatorLayer.instanceAlphaOffset = -1.0 / 15.0
        replicatorLayer.instanceBlueOffset = 1.0 / 15
        replicatorLayer.instanceColor = UIColor.red.cgColor
    }
    
    /// demo of a dot following path animation
    private func followingPath(_ view: UIView) {
        let path = following(view)
        //
        let replicatorLayer = CLReplicatorLayer()
        replicatorLayer.bounds = view.frame;
        replicatorLayer.position = view.center;
        view.layer.addSublayer(replicatorLayer)
        //
        let layer = CALayer()
        layer.backgroundColor = UIColor.red.cgColor
        layer.cornerRadius = 5
        layer.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
        layer.position = CGPoint(x: 20, y: view.center.y)
        replicatorLayer.addSublayer(layer)
        //
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = path.cgPath
        animation.duration = 3
        animation.repeatCount = MAXFLOAT
        layer.add(animation, forKey: "LayerPositionFollow")
        //
        replicatorLayer.instanceCount = 15
        replicatorLayer.instanceDelay = 0.3
    }
    
    private func following(_ view: UIView) -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 20, y: view.center.y))
        path.addCurve(to: CGPoint(x: screen_width - 20, y: view.center.y), controlPoint1: CGPoint(x: 130, y: view.center.y - 100), controlPoint2: CGPoint(x: 240, y: view.center.y + 100))
        path.close()
        return path
    }
}
