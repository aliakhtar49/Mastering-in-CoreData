//
//  CrudOperationWIthoutObjectOriented.swift
//  CrudOperationCoreData
//
//  Created by Ali Akhtar on 28/03/2019.
//  Copyright © 2019 Ali Akhtar. All rights reserved.
//

import Foundation
import CoreData
import UIKit


struct CrudOperationWIthoutObjectOriented {
    func addToDoTask(){
        
        //get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //We create a entity object Task is our entity and we are creating in this managedObjectContext
        let todoEntity = NSEntityDescription.entity(forEntityName: "Task", in: managedObjectContext)!
        
        
        //Adding records in TODO list
        let todo = NSManagedObject(entity: todoEntity, insertInto: managedObjectContext)
        
        todo.setValue("First Item", forKey: "name")
        todo.setValue("First Item Description", forKey: "details")
        todo.setValue(1, forKey: "id")
        
        //Save to persitsent store
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    func fetchTaskFromCoreData() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            //4) Execute fetchh request
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            //5) Print Data
            for data in tasks {
                print(data.value(forKey: "details") ?? "No Data found")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    func deleteTaskFromCoreData() {
        //1) get reference to app delegate singleton instance
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //2) We need context from container Entity needs context to create objects
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        
        //3) create fetchh request
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            //4) Execute fetchh request
            let tasks = try managedObjectContext.fetch(fetchRequest)
            
            //5) Print Data
            for data in tasks {
                managedObjectContext.delete(data)
                
            }
            //6 Commit to disk also
            do {
                try managedObjectContext.save() // <- remember to put this :)
            } catch let error as NSError{
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
}
