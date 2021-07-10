//
//  CLAnimationViewController.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/7.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit
import Lottie

enum CLAnimation: Int {
    case progress
    case path
    case wave
    case fireworks
    case lottie
    case otherEffect
}

class CLAnimationViewController: UIViewController {

    var animationType: CLAnimation = .path
    private var lottie: CLLottieManager?
    private var progressView: CLProgressView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        display()
    }
    
    deinit {
        lottie = nil
    }

    /// display any animation effect from 'CLAnimation' type, you can view the animation's detail in this code.
    private func display() {
        switch animationType {
        case .progress:
            view.backgroundColor = UIColor.white
            progressDisplay()
            let start = UIButton(type: .custom)
            start.frame = CGRect(x: view.bounds.width / 2 - 20,
                                 y: view.bounds.height - 200,
                                 width: 40,
                                 height: 30)
            start.setTitle("start", for: .normal)
            start.setTitleColor(.blue, for: .normal)
            view.addSubview(start)
            start.addTarget(self,
                            action: #selector(animationStart),
                            for: .touchUpInside)
        case .path:
            view.backgroundColor = UIColor.black
            CLShapeLayer.show(inView: view)
        case .wave:
            CLReplicatorLayer.show(inView: view)
        case .fireworks:
            view.backgroundColor = UIColor.black
            CLEmitterLayer.showFireworks(view)
        case .lottie:
            lottieDisplay()
        case .otherEffect:
            let progressView = CLScaleProgressView(frame: CGRect(x: 30,
                                                                 y: 180,
                                                                 width: screenWidth - 60,
                                                                 height: screenWidth - 60))
            view.addSubview(progressView)
            progressView.showAnimation()
        }
    }
    
    /// demo of a progress view animation display
    private func progressDisplay() {
        let progressView = CLProgressView(frame: CGRect(x: 30,
                                                        y: 180,
                                                        width: screenWidth - 60,
                                                        height: screenWidth - 60))
        view.addSubview(progressView)
        self.progressView = progressView
    }
//
//    /// any animation style
    @objc private func animationStart() {
        progressView?.animationShow(80)
    }
    
    /// demo of lottie animation display
    private func lottieDisplay() {
        lottie = CLLottieManager.show(inView: view,
                                      .deliver) {(animationView, finished) in
            
        }
    }

}
