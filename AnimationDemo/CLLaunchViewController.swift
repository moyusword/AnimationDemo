//
//  CLLaunchViewController.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/7.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

class CLLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    /// creat an animation view and play it.
    private func loadAnimation() {
        CLLottieManager.show(inView: view, .circle) {[weak self] (animationView, finished) in
            if finished {
                animationView.removeFromSuperview()
                guard let strongSelf = self else { return }
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(identifier: "ViewController")
                strongSelf.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

}
