//
//  CoreDataStack.swift
//  QuickGem-ios
//
//  Created by macos on 02/03/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private init() {}
    static let shared = CoreDataStack()

    lazy var persistentContainer: NSPersistentContainer = {
       let container = NSPersistentContainer(name: "WhyCats")

        container.loadPersistentStores(completionHandler: { (_, error) in
            guard let error = error as NSError? else { return }
            fatalError("Unresolved error: \(error), \(error.userInfo)")
        })

        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.undoManager = nil
        container.viewContext.shouldDeleteInaccessibleFaults = true

        container.viewContext.automaticallyMergesChangesFromParent = true

        return container
    }()
    
}
