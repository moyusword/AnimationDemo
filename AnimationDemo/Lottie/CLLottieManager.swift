//
//  CLLottieManager.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/7.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit
import Lottie

enum LottieAnimationItem {
    case deliver
    case circle
}

class CLLottieManager: NSObject {
    
    var animationView: AnimationView?
    
    /// show the animation at a view, you can choose any different animation type to your view.
    /// you should keep the view's frame is nonull.
    static func show(inView view: UIView, _ type: LottieAnimationItem, _ completed: ((AnimationView, Bool) -> ())?) -> CLLottieManager {
        let manager = CLLottieManager()
        
        var animationView: AnimationView?
        switch type {
        case .deliver:
            animationView = manager.deliverDelight()
            animationView?.frame = view.bounds
        default:
            animationView = manager.circleLoop()
            animationView?.frame = CGRect(x: 0, y: 80, width: screen_width, height: screen_width)
        }
        
        if let childView = animationView {
            view.addSubview(childView)
            manager.play(completed)
        }
        
        return manager
    }
    
    /// laod lottie source from any json, and creat a animationView with the default config, return a 'AnimationView' object.
    /// laod lottie source from 'deliver-delight' json.
    private func deliverDelight() -> AnimationView? {
        let bundleJsonNameString = "deliver-delight"//"stay-home"
        animationView = AnimationView(name: bundleJsonNameString)
        animationView?.contentMode = .scaleAspectFill
        animationView?.loopMode = .loop
        return animationView
    }
    
    /// laod lottie source from 'circle-loop' json
    private func circleLoop() -> AnimationView? {
        let bundleJsonNameString = "circle-loop"
        animationView = AnimationView(name: bundleJsonNameString)
        animationView?.contentMode = .scaleAspectFill
        return animationView
    }
    
    /// play the animation with 'AnimationView' api, and use completed block return the animation's state.
    private func play(_ callback: ((AnimationView, Bool) -> ())?) {
        guard let animationView = animationView else { return }
        animationView.play { (finished) in
            callback?(animationView, finished)
        }
    }
}
