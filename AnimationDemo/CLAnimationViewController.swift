//
//  CLAnimationViewController.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/7.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

enum CLAnimation {
    case path
    case wave
    case fireworks
    case lottie
}

class CLAnimationViewController: UIViewController {

    var animationType: CLAnimation = .path
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        display()
    }

    /// display any animation effect from 'CLAnimation' type, you can view the animation's detail in this code.
    private func display() {
        switch animationType {
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
        }
    }
    
    /// demo of lottie animation display
    private func lottieDisplay() {
        CLLottieManager.show(inView: view, .deliver) {[weak self] (animationView, finished) in
            guard let strongSelf = self else { return }
            animationView.removeFromSuperview()
            strongSelf.lottieDisplay()
        }
    }

}
