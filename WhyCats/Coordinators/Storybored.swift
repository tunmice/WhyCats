//
//  Storybored.swift
//  QuickGem-ios
//
//  Created by macos on 21/04/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation
import UIKit
protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    @available(iOS 13.0, *)
    static func instantiate() -> Self {
        
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(identifier: id) as! Self
        
    }
}
