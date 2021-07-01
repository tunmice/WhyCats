//
//  MainCoordinator.swift
//  QuickGem-ios
//
//  Created by macos on 21/04/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation

import UIKit

class MainCoordinator: NSObject,Coordinator, UINavigationControllerDelegate {
    
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.delegate = self
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
   
    
    func toOnBoarding() {
        
        
    }
    
    func toTabBar() {
       let child = TabBarCoordinator(navigationController: navigationController)
        child.parentCoordinator = self
        childCoordinators.append(child)
        child.start()
    }
    
    
    
    
    func childDidFinish(_ child: Coordinator?){
        for (index,coordinator) in childCoordinators.enumerated(){
            if coordinator === child  {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
    
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
    }
}
