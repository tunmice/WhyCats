//
//  AllCatsCoreDataModel.swift
//  WhyCats
//
//  Created by macos on 02/07/2021.
//

import Foundation
import CoreData

@objc(AllCatsCoreDataModel)

public class AllCatsCoreDataModel: NSManagedObject {

    
    func updateWithCats(cats: CatsModel){
        self.name = cats.name ?? ""
        
        self.image = cats.image?.url ?? ""
       
      
    }
}


extension AllCatsCoreDataModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AllCatsCoreDataModel> {
        return NSFetchRequest<AllCatsCoreDataModel>(entityName: "AllCatsCoreDataModel")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
   
   

}


