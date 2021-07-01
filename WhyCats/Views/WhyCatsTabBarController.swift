//
//  WhyCatsTabBarController.swift
//  WhyCats
//
//  Created by macos on 01/07/2021.
//

import UIKit

class WhyCatsTabBarController: UITabBarController {
    weak var coordinator: TabBarCoordinator?
    
    let allCats = AllCatsCoordinator(navigationController: UINavigationController())
    let likedCats = LikedCatsCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCats.start()
        likedCats.start()
        allCats.navigationController.tabBarItem.image = UIImage(named: "All Cats")
        likedCats.navigationController.tabBarItem.image = UIImage(named: "LikedHeart")
        viewControllers = [allCats.navigationController, likedCats.navigationController]

        
    }

    fileprivate func createNavController(viewController: UINavigationController, title: String, imageName: String) -> UIViewController {
             let navController = viewController
             navController.navigationBar.prefersLargeTitles = true
        viewController.navigationController?.setNavigationBarHidden(false, animated: true)
        viewController.navigationItem.title = title
    //    navController.isNavigationBarHidden = true
        navController.navigationBar.isTranslucent = true
//        navController.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navController.navigationBar.shadowImage = UIImage()
           navController.view.backgroundColor = UIColor.green
             navController.tabBarItem.title = title
             navController.tabBarItem.image = UIImage(named: imageName)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.isHidden = false
             return navController
             
         }

}
