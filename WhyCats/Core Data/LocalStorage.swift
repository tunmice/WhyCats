//
//  LocalStorage.swift
//  QuickGem-ios
//
//  Created by macos on 02/03/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation
import DefaultsKit

class LocalStorage {
    static let sharedInstance = Defaults()
}

extension DefaultsKey {
    
    static let likedBoolean = Key<Bool>("likedBoolean")
   
    
    
}

