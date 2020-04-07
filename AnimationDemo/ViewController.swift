//
//  ViewController.swift
//  AnimationDemo
//
//  Created by Leonard on 2020/4/3.
//  Copyright © 2020 leonard. All rights reserved.
//

import UIKit

let screen_width = UIScreen.main.bounds.width
let screen_height = UIScreen.main.bounds.height

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    lazy var animations: [[String]] = {
        let animations = [["CAShapeLayer"], ["CAReplicatorLayer"], ["CAEmitterLayer"], ["Lottie"]]
        return animations
    }()
    
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
        switch indexPath.section {
        case 0:
            controller.animationType = .path
        case 1:
            controller.animationType = .wave
        case 2:
            controller.animationType = .fireworks
        case 3:
            controller.animationType = .lottie
        default:
            break
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}

