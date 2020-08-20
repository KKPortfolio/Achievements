//
//  CoreDataManager.swift
//  Achievements
//
//  Created by Kurt Kim on 2020-08-18.
//  Copyright © 2020 Kurt Kim. All rights reserved.
//

import CoreData
import UIKit

class CoreDataManager {
    
    static let shared  = CoreDataManager()
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func save(){
        do {
            try context.save()
        } catch let error as NSError {
            print("save error: \(error), \(error.userInfo)")
        }
    }
    
    func fetch(entity: String)->[NSManagedObject]{
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: entity)
        var fetchedResults: [NSManagedObject] = []
        do {
            fetchedResults = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("fetch error: \(error), \(error.userInfo)")
        }
        return fetchedResults
    }
    
    func deleteAllEntry(){
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
        let request = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try context.execute(request)
        } catch let error as NSError {
            print("delete error: \(error), \(error.userInfo)")
        }
        self.save()
    }
}
