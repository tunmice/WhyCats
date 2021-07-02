//
//  BaseDao.swift
//  QuickGem-ios
//
//  Created by macos on 02/03/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation
import CoreData

class BaseDao {
    let persistentContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
           return persistentContainer.viewContext
       }
    

    init(persistentContainer: NSPersistentContainer) {
        self.persistentContainer = persistentContainer
    }

    func startTask()->NSManagedObjectContext{
        let taskContext = self.persistentContainer.newBackgroundContext()
              taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
              taskContext.undoManager = nil
        return taskContext
    }


    func getAllItems<T:NSManagedObject>(objectType:T.Type,fetchRequest:NSFetchRequest<NSFetchRequestResult>) -> [T] {
        fetchRequest.returnsObjectsAsFaults = false
         do {
                      let arrayOfData = try viewContext.fetch(fetchRequest) as? [T]
                      return arrayOfData ?? Array<T>()
                  } catch {
                      return Array<T>()
                  }
    }


    func deleteAllExisitingItems (taskContext:NSManagedObjectContext,entityName:String)  {
               let matchingRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
               let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: matchingRequest)
               batchDeleteRequest.resultType = .resultTypeObjectIDs
                      do {
                          let batchDeleteResult = try taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult

                          if let deletedObjectIDs = batchDeleteResult?.result as? [NSManagedObjectID] {
                              NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs],
                                                                  into: [self.persistentContainer.viewContext])
                          }
                      } catch {
                          print("Error: \(error)\nCould not batch delete existing records.")
                          return
                      }

           }

     func addAllItems<R:Codable,T:NSManagedObject> (withItems:[R],taskContext:NSManagedObjectContext,objectType:T.Type,updateEntity: (R,T)->()  ){
           for item in withItems{
              let entity = T(context: taskContext)
            updateEntity(item,entity)
           }
    }

     func saveChanges(taskContext:NSManagedObjectContext)->Bool{
        var successful = false
        if taskContext.hasChanges {
                do {
                    try taskContext.save()
                    successful = true
                    } catch {
                                   print("Error: \(error)\nCould not save Core Data context.")
                                                   }
                       taskContext.reset() // Reset the context to clean up the cache and low the memory footprint.
                                               }
        return successful
    }

}

