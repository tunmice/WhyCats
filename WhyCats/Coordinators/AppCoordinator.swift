//
//  AppCoordinator.swift
//  QuickGem-ios
//
//  Created by macos on 21/04/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    
  func start()
}



