//
//  TabBarCoordinator.swift
//  Flenjor
//
//  Created by macos on 05/05/2021.
//

import Foundation
import UIKit
class TabBarCoordinator: Coordinator {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
      let vc = WhyCatsTabBarController()
        vc.coordinator = self
       
//        navigationController.setNavigationBarHidden(true, animated: false)
        navigationController.pushViewController(vc, animated: true)
    }
    
   
    
    
}
