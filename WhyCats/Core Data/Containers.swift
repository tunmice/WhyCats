//
//  Containers.swift
//  QuickGem-ios
//
//  Created by macos on 02/03/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation

import Swinject
import SwinjectAutoregistration
import CoreData

extension Container {
    
    
    static let sharedContainer:Container = {
        let container  = Container()
        
        
        
        //MARK:-Dao
        container.autoregister(NSManagedObjectContext.self, initializer: {CoreDataStack.shared.persistentContainer.viewContext})
        container.autoregister(NSPersistentContainer.self, initializer: {CoreDataStack.shared.persistentContainer})
        container.autoregister(BaseDao.self, initializer: BaseDao.init)
        container.autoregister(CatsDao.self, initializer: {CatsDaoImpl(persistentContainer: CoreDataStack.shared.persistentContainer)})
    
        container.autoregister(CatsRepo.self, initializer: CatsRepoImpl.init)
        
        
        return container
}()

}
