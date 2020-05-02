//
//  CLProgressView.swift
//  AnimationDemo
//
//  Created by DerekYuYi on 2020/4/20.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

class CLProgressView: UIView {
    
    private let scaleCount = 50
    private var animatePercent: CGFloat = 0
    private let angleRadius: CGFloat = 95
    private let scaleRadius: CGFloat = 150
    private let textRadius: CGFloat = 135
    private let progressRadius: CGFloat = 120
    private let angleWidth: CGFloat = 5
    private let progressWidth: CGFloat = 50
    private let angleColor: UIColor = UIColor(red: 185/255, green: 243/255, blue: 110/255, alpha: 1)
    private var aniDuration: Double = 2
    private var progressTime: TimeInterval = 0
    private var lastUpdate: TimeInterval = 0
    private var totalTime: TimeInterval = 0
    private var animateValue: Double = 0
    private var currentValue: Double = 0
    
    private var timer: CADisplayLink?
    private var progressLayer: CLShapeLayer?
    private var valueTextLbl: UILabel?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        halfAngle()
        angleScale()
        speedValueText()
        progress()
    }
    
    /// start the animation.
    func animationShow(_ speed: Double) {
        animatePercent = 0
        animateValue = 0
        totalTime = 0
        progressTime = 0
        lastUpdate = 0
        currentValue = speed
        totalTime = aniDuration
        animatePercent = CGFloat(speed / 100)
        lastUpdate = CACurrentMediaTime()
        aniDuration = 2
        timer = CADisplayLink(target: self, selector: #selector(timerRun))
        if #available(iOS 10.0, *) {
            timer?.preferredFramesPerSecond = 15
        } else {
            timer?.frameInterval = 15
        }
        timer?.add(to: RunLoop.main, forMode: .default)
        timer?.add(to: RunLoop.main, forMode: .tracking)
        renderProgress(progressLayer!)
    }
    
    /// draw an half circle angle.
    private func halfAngle() {
        let circle = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.height / 1.5), radius: angleRadius, startAngle: -CGFloat(Double.pi), endAngle: 0, clockwise: true)
        let shapeLayer = CLShapeLayer()
        shapeLayer.lineWidth = angleWidth
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = angleColor.cgColor
        shapeLayer.path = circle.cgPath
        layer.addSublayer(shapeLayer)
    }
    
    /// draw some scale at the half circle angle edge.
    private func angleScale() {
        let preAngle = Double.pi / Double(scaleCount)
        
        for i in 0..<scaleCount+1 {
            
            let startAngle = -Double.pi + preAngle * Double(i)
            let endAngle = startAngle + preAngle / 5
            
            let tickPath = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.height / 1.5), radius: scaleRadius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true)
            
            let preLayer = CLShapeLayer()
            if i % 5 == 0 {
                preLayer.strokeColor = UIColor(red: 0.62, green: 0.84, blue: 0.93, alpha: 1).cgColor
                preLayer.lineWidth = 10
                scaleValues(-endAngle, i)
            } else {
                preLayer.strokeColor = UIColor(red: 0.22, green: 0.66, blue: 0.93, alpha: 1).cgColor
                preLayer.lineWidth = 5
            }
            preLayer.path = tickPath.cgPath
            layer.addSublayer(preLayer)
        }
    }
    
    /// add the scales value.
    private func scaleValues(_ angle: Double, _ index: Int) {
        let point = calculateTextPosition(angle)
        let tickText = "\(index * 2)"
        let text = UILabel(frame: CGRect(x: point.x - 9, y: point.y - 7, width: 18, height: 14))
        text.text = tickText
        text.font = UIFont.systemFont(ofSize: 8)
        text.textColor = UIColor(red: 0.54, green: 0.78, blue: 0.91, alpha: 1)
        text.textAlignment = .center
        addSubview(text)
    }
    
    /// the progress changed.
    private func progress() {
        let progressPath = UIBezierPath(arcCenter: CGPoint(x: frame.width / 2, y: frame.height / 1.5), radius: progressRadius, startAngle: -CGFloat(Double.pi), endAngle: 0, clockwise: true)
        
        let progressLayer = CLShapeLayer()
        progressLayer.lineWidth = progressWidth
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeColor = UIColor(red: 185/255, green: 243/255, blue: 110/255, alpha: 0.2).cgColor
        progressLayer.path = progressPath.cgPath
        progressLayer.strokeStart = 0
        progressLayer.strokeEnd = 0
        layer.addSublayer(progressLayer)
        self.progressLayer = progressLayer
    }
    
    /// the speed text.
    private func speedValueText() {
        let speed = UILabel(frame: CGRect(x: frame.width / 2 - 20, y: frame.height / 1.5 - 30, width: 40, height: 30))
        speed.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        speed.textAlignment = .center
        speed.textColor = .orange
//        speed.text = "80"
        addSubview(speed)
        self.valueTextLbl = speed
    }
    
    /// animation render.
    private func renderProgress(_ layer: CAShapeLayer) {
        // render
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.fromValue = 0
        strokeAnimation.toValue = animatePercent
        strokeAnimation.duration = aniDuration
        strokeAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        strokeAnimation.fillMode = .forwards
        strokeAnimation.isRemovedOnCompletion = false
        layer.add(strokeAnimation, forKey: nil)
    }
    
    /// displaylink.
    @objc private func timerRun() {
        //计算进度获取动画步数
        let now = CACurrentMediaTime()
        progressTime += now - lastUpdate
        lastUpdate = now
        
        if progressTime >= totalTime {
            progressTime = totalTime
        }
        animationValue()
        valueTextLbl?.text = String(format: "%.f", animateValue)
    }
    
    /// animate value.
    private func animationValue() {
        if progressTime >= totalTime {
            animateValue = currentValue
            return
        }
        let percent = progressTime / totalTime
        var updateVal = Float(2 * percent)
        if updateVal < 1 {
            updateVal = 0.5 * powf(updateVal, 3)
        } else {
            updateVal = 0.5 * (2 - powf(2 - updateVal, 3))
        }
        animateValue = Double(updateVal) * currentValue
    }
    
    /// calculate the text position.
    private func calculateTextPosition(_ angle: Double) -> CGPoint {
        let centers = CGPoint(x: frame.width / 2, y: frame.height / 1.5)
        let x = textRadius * CGFloat(cos(angle))
        let y = textRadius * CGFloat(sin(angle))
        return CGPoint(x: centers.x + x, y: centers.y - y)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
