//
//  AccountsDao.swift
//  QuickGem-ios
//
//  Created by macos on 02/03/2021.
//  Copyright © 2021 macos. All rights reserved.
//

import Foundation
import CoreData

protocol CatsDao:BaseDao {
    func fetchCats() -> [AllCatsCoreDataModel]
  func insertCats(withCats: [CatsModel]) ->Bool
}

class CatsDaoImpl:BaseDao, CatsDao{



    // Get All Organizations
    func fetchCats()  -> [AllCatsCoreDataModel] {
           var request = NSFetchRequest<NSFetchRequestResult>()
           request = AllCatsCoreDataModel.fetchRequest()
           request.sortDescriptors = [NSSortDescriptor(key: "name", ascending:true)]
        return getAllItems(objectType: AllCatsCoreDataModel.self, fetchRequest: request )
    }



    // Insert List of organizations
    // First Delete Exisiting Items Before Updating
   func insertCats(withCats: [CatsModel]) ->Bool {
       let taskContext = startTask()
    taskContext.performAndWait {
//        let accountIDs = withAccounts.map {  $0.accountCreatedDate }.compactMap { $0 }
        deleteAllExisitingItems(taskContext:taskContext,entityName: "AllCatsCoreDataModel")

     addAllItems(withItems:withCats,taskContext:taskContext,objectType:AllCatsCoreDataModel.self,
                 updateEntity: {(cats,allCatsCoreDataModel) in
                    (allCatsCoreDataModel as AllCatsCoreDataModel).updateWithCats(cats: cats)
                    taskContext.insert(allCatsCoreDataModel)
        })
   }
    return saveChanges(taskContext: taskContext)
}
}
