//
//  LikedCatsViewController.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

class LikedCatsViewController: UIViewController {
    var coordinator: LikedCatsCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
setAppearances()
    }

    func setAppearances() {
        navigationItem.title = "Liked Cats"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.tabBarItem.image = UIImage(named: "LikedHeart")
    }

    

}
