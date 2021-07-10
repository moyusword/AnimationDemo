//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/3.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var animations = [["Progress"],
                           ["CAShapeLayer"],
                           ["CAReplicatorLayer"],
                           ["CAEmitterLayer"],
                           ["Lottie"],
                           ["OtherTestEffect"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 50
        tableView.sectionHeaderHeight = 39
        tableView.sectionFooterHeight = CGFloat.leastNonzeroMagnitude
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return animations.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animations[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = animations[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let controller = CLAnimationViewController()
        controller.animationType = CLAnimation(rawValue: indexPath.section) ?? .progress
        navigationController?.pushViewController(controller, animated: true)
    }
}

