//
//  CLScaleProgressView.swift
//  AnimationDemo
//
//  Created by DerekYuYi on 2020/4/21.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

class CLScaleProgressView: UIView {
    
    private let scaleDivisionsLength: CGFloat = 14
    private let scaleDivisionsWidth: CGFloat = 4
    private let lineBgColor: UIColor = .gray
    private let scaleCount = 50
    private let scaleColor: UIColor = .yellow
    private let scaleMargin: CGFloat = 5
    private var scaleRect: CGRect = CGRect.zero
    private var animatePercent: CGFloat = 0
    
    private var timer: Timer?
    private var shapeLayer: CLShapeLayer?
    private var replicatorLayer: CLReplicatorLayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        scaleLayer()
        animationScaleLayer(true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func showAnimation() {
        //1.1
//        circleProgressLayer()
//        circleProgressAnimation()
        
        //1.2  open draw(rect:)
//        creatTimer()
        
        //1.3
        guard let sublayers = replicatorLayer?.sublayers else { return }
        for layer in sublayers {
            // animation property
            if let shapeLayer = layer as? CLShapeLayer {
                opacityAnimationProgress(shapeLayer)
            }
        }
    }
    
    /// draw
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        drawScale(context)
        drawProcessScale(context)
    }
    
    /// use layer
    private func scaleLayer() {
        //CAReplicatorLayer
        let replicatorLayer = CLReplicatorLayer()
        replicatorLayer.bounds = bounds
        replicatorLayer.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        layer.addSublayer(replicatorLayer)
        self.replicatorLayer = replicatorLayer
        
        //CALayer
        let layer = CLShapeLayer()
        layer.backgroundColor = lineBgColor.cgColor
        layer.bounds = CGRect(x: 0, y: 0, width: scaleDivisionsWidth, height: scaleDivisionsLength)
        layer.position = CGPoint(x: bounds.width / 2, y: scaleMargin + scaleDivisionsLength / 2)
        replicatorLayer.addSublayer(layer)
        
        //config
        replicatorLayer.instanceCount = scaleCount
        replicatorLayer.preservesDepth = true
        var transform = CATransform3DIdentity
        let angle = Double.pi * 2 / Double(scaleCount)
        transform = CATransform3DRotate(transform, CGFloat(angle), 0, 0, 1)
        replicatorLayer.instanceTransform = transform
        replicatorLayer.instanceDelay = 0.1
    }
    
    /// animation layer
    private func animationScaleLayer(_ clockwise: Bool) {
        //CAReplicatorLayer
        let replicatorLayer = CLReplicatorLayer()
        replicatorLayer.bounds = bounds
        replicatorLayer.position = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        layer.addSublayer(replicatorLayer)
        self.replicatorLayer = replicatorLayer
        
        //CALayer
        let layer = CLShapeLayer()
        layer.backgroundColor = scaleColor.cgColor
        layer.opacity = 0
        layer.bounds = CGRect(x: 0, y: 0, width: scaleDivisionsWidth, height: scaleDivisionsLength)
        layer.position = CGPoint(x: bounds.width / 2, y: scaleMargin + scaleDivisionsLength / 2)
        replicatorLayer.addSublayer(layer)
        
        //config
        replicatorLayer.instanceCount = Int(Double(scaleCount) * 0.7)
        replicatorLayer.preservesDepth = true
        var transform = CATransform3DIdentity
        let angle = Double.pi * 2 / Double(scaleCount)
        transform = CATransform3DRotate(transform, clockwise ? CGFloat(angle) : -CGFloat(angle), 0, 0, 1)
        replicatorLayer.instanceTransform = transform
        replicatorLayer.instanceDelay = 0.1
    }
    
    /// timer
    private func creatTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { (timer) in
            self.progressChange()
        })
        timer?.fire()
    }
    
    /// the progress up with animation
    private func progressChange() {
        if animatePercent > 0.7 {
            animatePercent = 0.7
            timer?.invalidate()
        }
        animatePercent += 0.05
        setNeedsDisplay()
    }
    
    /// draw some circle scale.
    private func drawScale(_ context: CGContext) {
        // line.width
        context.setLineWidth(scaleDivisionsWidth)
        // reset
        context.translateBy(x: self.frame.width / 2, y: self.frame.width / 2)
        context.setStrokeColor(lineBgColor.cgColor)
        // start
        context.rotate(by: CGFloat(Double.pi / 2))
        for _ in 0..<scaleCount {
            context.move(to: CGPoint(x: scaleRect.width / 2 - scaleDivisionsLength, y: 0))
            context.addLine(to: CGPoint(x: scaleRect.width / 2, y: 0))
            context.strokePath()
            context.rotate(by: CGFloat(2 * Double.pi / Double(scaleCount)))
        }
        context.translateBy(x: -self.frame.width / 2, y: -self.frame.width / 2)
    }
    
    /// draw some scale with color use as progress.
    private func drawProcessScale(_ context: CGContext) {
        // line.width
        context.setLineWidth(scaleDivisionsWidth)
        // reset
        context.translateBy(x: self.frame.width / 2, y: self.frame.height / 2)
        context.setStrokeColor(scaleColor.cgColor)
        // start
        let count = Int(CGFloat((scaleCount / 2 + 1)) * animatePercent)
        let scaleAngle = CGFloat(2 * Double.pi / Double(scaleCount))
        for _ in 0..<count {
            context.move(to: CGPoint(x: scaleRect.width / 2 - scaleDivisionsLength, y: 0))
            context.addLine(to: CGPoint(x: scaleRect.width / 2, y: 0))
            context.strokePath()
            context.rotate(by: -scaleAngle)
        }
        context.rotate(by: CGFloat(count) * scaleAngle)
        
        for _ in 0..<count {
            context.move(to: CGPoint(x: scaleRect.width / 2 - scaleDivisionsLength, y: 0))
            context.addLine(to: CGPoint(x: scaleRect.width / 2, y: 0))
            context.strokePath()
            context.rotate(by: scaleAngle)
        }
        context.translateBy(x: -self.frame.width / 2, y: -self.frame.width / 2)
    }
    
    // MARK: - a circle progress and use fill
    /// circle progress
    private func circleProgressLayer() {
        let progressLayer = CLShapeLayer()
        progressLayer.frame = self.bounds
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = scaleDivisionsWidth
        progressLayer.lineCap = .round
        progressLayer.strokeColor = lineBgColor.cgColor
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 1
        progressLayer.path = circleRingPath().cgPath
        layer.addSublayer(progressLayer)
        
        let renderLayer = CLShapeLayer()
        renderLayer.frame = self.bounds
        renderLayer.fillColor = UIColor.clear.cgColor
        renderLayer.lineWidth = scaleDivisionsWidth
        renderLayer.lineCap = .round
        renderLayer.strokeColor = scaleColor.cgColor
        renderLayer.strokeStart = 0
        renderLayer.strokeEnd = 0
        renderLayer.path = circleRingPath().cgPath
        layer.addSublayer(renderLayer)
        shapeLayer = renderLayer
    }
    
    /// start animation
    private func circleProgressAnimation() {
        shapeLayer?.strokeColor = scaleColor.cgColor
        guard let progressLayer = shapeLayer else { return }
        renderProgress(progressLayer)
    }
    
    /// animation render
    private func renderProgress(_ layer: CAShapeLayer) {
        // render
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = 0.7
        strokeAnimation.duration = 0.25
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        strokeAnimation.fillMode = .forwards
        strokeAnimation.isRemovedOnCompletion = false
        layer.add(strokeAnimation, forKey: nil)
    }
    
    private func opacityAnimationProgress(_ layer: CAShapeLayer) {
        // render
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 0.25
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        layer.add(animation, forKey: nil)
    }
    
    /// circle
    private func circleRingPath() -> UIBezierPath {
        //angle
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: self.frame.width / 2, y: self.frame.height / 2), radius: (self.frame.width - 17) / 2, startAngle: -CGFloat(Double.pi), endAngle: CGFloat(Double.pi), clockwise: true)
        return circlePath
    }
    
}
