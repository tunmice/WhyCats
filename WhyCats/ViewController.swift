//
//  ViewController.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController, Storyboarded {
    var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        coordinator?.toTabBar()
    }


}

