//
//  SearchPageCoordinator.swift
//  Flenjor
//
//  Created by macos on 05/05/2021.
//

import Foundation
import UIKit
class LikedCatsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    func start() {
       
        let vc = LikedCatsViewController()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
    
}
